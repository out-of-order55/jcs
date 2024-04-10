/////////////////////////////////////
// Bit controller section
/////////////////////////////////////
//
// Translate simple commands into SCL/SDA transitions
// Each command has 5 states, A/B/C/D/idle

// start:
// SCL x ~ ~ ~\_
// SDA ~ ~\_ _ _
// x | A | B | C | D | i
// scl_oen: x1110
// sda_oen: 11000

// stop:
// SCL	_/~ ~ ~
// SDA	_ _ _/~
// x | A | B | C | D | i
// scl_oen: 0111
// sda_oen: 0001

// write:
// SCL _/~ ~\_
// SDA d d d d
// x | A | B | C | D | i
// scl_oen: 0110
// sda_oen: {din_r, din_r, din_r, din_r}

// read:
// SCL _/~ ~\_
// SDA ~ ~ ~ ~
// x | A | B | C | D | i
// scl_oen: 0110
// sda_oen: 1111

// Timing:     Normal mode      Fast mode
///////////////////////////////////////////////////////////////////////
// Fscl        100KHz           400KHz
// Th_scl      4.0us            0.6us   High period of SCL
// Tl_scl      4.7us            1.3us   Low period of SCL
// Tsu:sta     4.7us            0.6us   setup time for a repeated start condition
// Tsu:sto     4.0us            0.6us   setup time for a stop conditon
// Tbuf        4.7us            1.3us   Bus free time between a stop and start condition
//
module i2c_master_bit_ctrl (
	clk, 
	rstn, 
	clk_en,
	clk_cnt, 
	ena, 
	cmd, 
	cmd_ack, 
	busy, 
	al, 
	din, 
	dout, 
	fsm_busy_i,
	scl_i, 
	scl_oen, 
	sda_i, 
	sda_oen
);

	//
	// inputs & outputs
	//

	input clk;
	input rstn;
	input ena;            // core enable signal

	input [15:0] clk_cnt; // clock prescale value

	input  [3:0] cmd;
	output       cmd_ack; // command complete acknowledge
	reg cmd_ack;
	output       busy;    // i2c bus busy
	reg busy;
	output       al;      // i2c bus arbitration lost
	reg al;

    input fsm_busy_i;
	input  din;
	output dout;
	reg dout;

	// I2C lines
	input  scl_i;         // i2c clock line input
	output scl_oen;       // i2c clock line output enable (active low)
	reg scl_oen;
	input  sda_i;         // i2c data line input
	output sda_oen;       // i2c data line output enable (active low)
	reg sda_oen;

    output clk_en;

	//
	// variable declarations
	//

	reg sSCL, sSDA;             // synchronized SCL and SDA inputs
	reg dscl_oen;               // delayed scl_oen
	reg sda_chk;                // check SDA output (Multi-master arbitration)
	wire slave_wait;
	reg [15:0] cnt;             // clock divider counter

	// state machine variable
	reg [16:0] c_state;

	//
	// module body
	//

	// whenever the slave is not ready it can delay the cycle by pulling SCL low
	// delay scl_oen
	always @(posedge clk)
		dscl_oen <= scl_oen;

	assign slave_wait = dscl_oen && !sSCL;

	// generate clk enable signal
    always @(posedge clk)
        if(~rstn)               cnt <= 16'h0;
        else if(~|cnt || ~ena)  cnt <= clk_cnt;// if clk_cnt is 0x13, corresponding to 100k.
        else if(~slave_wait)    cnt <= cnt - 1'b1;

    assign clk_en = ~|cnt & ~slave_wait;// divide clk by clk_cnt to obtain clk_en, namely, clk_en = clk / clk_cnt.

	// generate bus status controller
	reg dSCL, dSDA;
	reg sta_condition;
	reg sto_condition;

	// synchronize SCL and SDA inputs
	// reduce metastability risc
	always @(posedge clk)
		if (!rstn) begin
			sSCL <= 1'b1;
			sSDA <= 1'b1;

			dSCL <= 1'b1;
			dSDA <= 1'b1;
		end
		else begin
			sSCL <= scl_i;
			sSDA <= sda_i;

			dSCL <= sSCL;
			dSDA <= sSDA;
		end

	// detect start condition => detect falling edge on SDA while SCL is high
	// detect stop condition => detect rising edge on SDA while SCL is high
	always @(posedge clk)
		if (!rstn) begin
			sta_condition <= 1'b0;
			sto_condition <= 1'b0;
		end
		else begin
			sta_condition <= ~sSDA &  dSDA & sSCL;
			sto_condition <=  sSDA & ~dSDA & sSCL;
		end

	// generate i2c bus busy signal
	always @(posedge clk)
		if (!rstn)
			busy <= 1'b0;
		else
			busy <= (sta_condition | busy) & ~sto_condition;

	reg cmd_stop;
	always @(posedge clk)
		if (!rstn)
			cmd_stop <= 1'b0;
		else if (clk_en)
			cmd_stop <= cmd == `I2C_CMD_STOP;

	// generate arbitration lost signal
	// aribitration lost when:
	// 1) master drives SDA high, but the i2c data bus(SDA) is low
	// 2) stop detected while not requested 
	// ?
	always @(posedge clk)
		if (!rstn)
			al <= 1'b0;
		else
			al <= (sda_chk & ~sSDA & sda_oen) | (|c_state & sto_condition & ~cmd_stop);

	// generate dout signal (store SDA on rising edge of SCL)
	always @(posedge clk)
		if(sSCL & ~dSCL)
			dout <= sSDA;

	// generate statemachine
	// nxt_state decoder
	parameter [16:0] idle    = 17'b0_0000_0000_0000_0000;
	parameter [16:0] start_a = 17'b0_0000_0000_0000_0001;
	parameter [16:0] start_b = 17'b0_0000_0000_0000_0010;
	parameter [16:0] start_c = 17'b0_0000_0000_0000_0100;
	parameter [16:0] start_d = 17'b0_0000_0000_0000_1000;
	parameter [16:0] start_e = 17'b0_0000_0000_0001_0000;
	parameter [16:0] stop_a  = 17'b0_0000_0000_0010_0000;
	parameter [16:0] stop_b  = 17'b0_0000_0000_0100_0000;
	parameter [16:0] stop_c  = 17'b0_0000_0000_1000_0000;
	parameter [16:0] stop_d  = 17'b0_0000_0001_0000_0000;
	parameter [16:0] rd_a    = 17'b0_0000_0010_0000_0000;
	parameter [16:0] rd_b    = 17'b0_0000_0100_0000_0000;
	parameter [16:0] rd_c    = 17'b0_0000_1000_0000_0000;
	parameter [16:0] rd_d    = 17'b0_0001_0000_0000_0000;
	parameter [16:0] wr_a    = 17'b0_0010_0000_0000_0000;
	parameter [16:0] wr_b    = 17'b0_0100_0000_0000_0000;
	parameter [16:0] wr_c    = 17'b0_1000_0000_0000_0000;
	parameter [16:0] wr_d    = 17'b1_0000_0000_0000_0000;

	reg din_r;// cmd_ack go back earlier, so din come earlier, need to store one cycle
	always @(posedge clk)
	if (!rstn | al) begin
		c_state <= idle;
		cmd_ack <= 1'b0;
		scl_oen <= 1'b1;
		sda_oen <= 1'b1;
		sda_chk <= 1'b0;
		din_r   <= 1'b0;
	end
	else begin
		cmd_ack <= 1'b0;// default no command acknowledge + assert cmd_ack only one clk cycle
		// I think putting 'cmd_ack <= 1'b0' here is not suitable.
		if (clk_en) begin
		din_r <= din; 
			case (c_state)// synopsys full_case parallel_case
			idle: begin
				case (cmd)// synopsys full_case parallel_case
					`I2C_CMD_START:
						c_state <= start_a;

					`I2C_CMD_STOP:
						c_state <= stop_a;

					`I2C_CMD_WRITE:
						c_state <= wr_a;

					`I2C_CMD_READ:
						c_state <= rd_a;

					default:
						c_state <= idle;
				endcase
				scl_oen <= scl_oen;// keep SCL in same state
				sda_oen <= sda_oen;// keep SDA in same state
				sda_chk <= 1'b0;   // don't check SDA output
			end

			// start
			start_a:
			begin
				c_state <= start_b;
				scl_oen <= scl_oen;// keep SCL in same state 
				// why keep SCL in same state?
				sda_oen <= 1'b1;   // set SDA high
				sda_chk <= 1'b0;   // don't check SDA output
			end

			start_b:
			begin
				c_state <= start_c;
				scl_oen <= 1'b1; 		// set SCL high
				sda_oen <= 1'b1; 		// keep SDA high
				sda_chk <= ~fsm_busy_i; // don't check SDA output
			end

			start_c:
			begin
				c_state <= start_d;
				scl_oen <= 1'b1;   // keep SCL high
				sda_oen <= 1'b0;   // set SDA low
				sda_chk <= 1'b0;   // don't check SDA output
			end

			start_d:
			begin
				c_state <= start_e;
				cmd_ack <= 1'b1;
				scl_oen <= 1'b1;   // keep SCL high
				sda_oen <= 1'b0;   // keep SDA low
				sda_chk <= 1'b0;   // don't check SDA output
			end

			start_e:
			begin
				case (cmd) // synopsys full_case parallel_case
					`I2C_CMD_START:
						c_state <= start_a;

					`I2C_CMD_STOP:
						c_state <= stop_a;

					`I2C_CMD_WRITE:
						c_state <= wr_a;

					`I2C_CMD_READ:
						c_state <= rd_a;

					default:
						c_state <= idle;
				endcase
				scl_oen <= 1'b0;// set SCL low
				sda_oen <= 1'b0;// keep SDA low
				sda_chk <= 1'b0;// don't check SDA output
			end
			/*
				scl_oen: x1110
				sda_oen: 11000
			*/

			// stop
			stop_a:
			begin
				c_state <= stop_b;
				scl_oen <= 1'b0; // keep SCL low
				sda_oen <= 1'b0; // set SDA low
				sda_chk <= 1'b0; // don't check SDA output
			end

			stop_b:
			begin
				c_state <= stop_c;
				scl_oen <= 1'b1; // set SCL high
				sda_oen <= 1'b0; // keep SDA low
				sda_chk <= 1'b0; // don't check SDA output
			end

			stop_c:
			begin
				c_state <= stop_d;
				scl_oen <= 1'b1; // keep SCL high
				sda_oen <= 1'b0; // keep SDA low
				sda_chk <= 1'b0; // don't check SDA output
			end

			stop_d:
			begin
				c_state <= idle;
				cmd_ack <= 1'b1;
				scl_oen <= 1'b1; // keep SCL high
				sda_oen <= 1'b1; // set SDA high
				sda_chk <= 1'b0; // don't check SDA output
			end
			/*
				scl_oen: 0111
				sda_oen: 0001
			*/

			// read
			rd_a:
			begin
				c_state <= rd_b;
				scl_oen <= 1'b0; // keep SCL low
				sda_oen <= 1'b1; // tri-state SDA
				sda_chk <= 1'b0; // don't check SDA output
			end

			rd_b:
			begin
				c_state <= rd_c;
				scl_oen <= 1'b1; // set SCL high
				sda_oen <= 1'b1; // keep SDA tri-stated
				sda_chk <= 1'b0; // don't check SDA output
			end

			rd_c:
			begin
				if(dSCL) c_state <= rd_d; // clock_synchronization
				cmd_ack <= 1'b1;
				scl_oen <= 1'b1; // keep SCL high
				sda_oen <= 1'b1; // keep SDA tri-stated
				sda_chk <= 1'b0; // don't check SDA output
			end

			rd_d:
			begin
				case (cmd) // synopsys full_case parallel_case
					`I2C_CMD_START:
						c_state <= start_a;

					`I2C_CMD_STOP:
						c_state <= stop_a;

					`I2C_CMD_WRITE:
						c_state <= wr_a;

					`I2C_CMD_READ:
						c_state <= rd_a;

					default:
					c_state <= idle;
				endcase
				scl_oen <= 1'b0; // set SCL low
				sda_oen <= 1'b1; // keep SDA tri-stated
				sda_chk <= 1'b0; // don't check SDA output
			end
			/*
				scl_oen: 0110
				sda_oen: 1111
			*/

			// write
			wr_a:
			begin
				c_state <= wr_b;
				scl_oen <= 1'b0; // keep SCL low
				sda_oen <= din_r;// set SDA
				sda_chk <= 1'b0; // don't check SDA output (SCL low)
			end

			wr_b:
			begin
				c_state <= wr_c;
				scl_oen <= 1'b1; // set SCL high
				sda_oen <= din_r;// keep SDA
				sda_chk <= 1'b1; // check SDA output
			end

			wr_c:
			begin
				if(dSCL) c_state <= wr_d; // clock synchronization
				cmd_ack <= 1'b1;
				scl_oen <= 1'b1; // keep SCL high
				sda_oen <= din_r;
				sda_chk <= 1'b1; // check SDA output
			end

			wr_d:
			begin
				case (cmd) // synopsys full_case parallel_case
					`I2C_CMD_START:
						c_state <= start_a;

					`I2C_CMD_STOP:
						c_state <= stop_a;

					`I2C_CMD_WRITE:
						c_state <= wr_a;

					`I2C_CMD_READ:
						c_state <= rd_a;

					default:
					c_state <= idle;
				endcase
				scl_oen <= 1'b0; // set SCL low
				sda_oen <= din_r;
				sda_chk <= 1'b0; // don't check SDA output (SCL low)
			end
			/*
				scl_oen: 0110
				sda_oen: {din_r, din_r, din_r, din_r}
			*/
				default:;
			endcase
	end
end
endmodule
