/////////////////////////////////////
// Bit controller section
/////////////////////////////////////
//
// Translate simple commands into SCL/SDA transitions
// Each command has 5 states, A/B/C/D/idle
//
// start:	SCL	~~~~~~~~~~\____
//	      SDA	~~~~~~~~\______
//		      x | A | B | C | D | i
//
// repstart	SCL	____/~~~~\___
//	        SDA	__/~~~\______
//		      x | A | B | C | D | i
//
// stop	SCL	____/~~~~~~~~
//	    SDA	==\____/~~~~~
//		 x | A | B | C | D | i
//
//- write	SCL	____/~~~~\____
//	      SDA	==X=========X=
//		 x | A | B | C | D | i
//
//- read	SCL	____/~~~~\____
//	      SDA	XXXX=====XXXX
//		 x | A | B | C | D | i
//

// Timing:     Normal mode      Fast mode
///////////////////////////////////////////////////////////////////////
// Fscl        100KHz           400KHz
// Th_scl      4.0us            0.6us   High period of SCL
// Tl_scl      4.7us            1.3us   Low period of SCL
// Tsu:sta     4.7us            0.6us   setup time for a repeated start condition
// Tsu:sto     4.0us            0.6us   setup time for a stop conditon
// Tbuf        4.7us            1.3us   Bus free time between a stop and start condition
//
`define I2C_CMD_NOP   4'b0000
`define I2C_CMD_START 4'b0001
`define I2C_CMD_STOP  4'b0010
`define I2C_CMD_WRITE 4'b0100
`define I2C_CMD_READ  4'b1000

module i2c_slave_bit_ctrl(
	clk, rst_,
	ena, cmd, cmd_ack, busy, din, dout, stop,
	scl_i, sda_i, sda_oen, sta_condition
	);

	//
	// inputs & outputs
	//
	input clk;
	input rst_;
	input ena;            // core enable signal

	input  [3:0] cmd;
	output       cmd_ack; // command complete acknowledge
	reg cmd_ack;
	output       busy;    // i2c bus busy
	reg busy;

	input  din;
	output dout;
	reg dout;
  output stop;
  reg stop;
	// I2C lines
	input  scl_i;         // i2c clock line input
	input  sda_i;         // i2c data line input
	output sda_oen;       // i2c data line output enable (active low)
	reg sda_oen;
  output sta_condition;

	//
	// variable declarations
	//

	reg sSCL, sSDA;             // synchronized SCL and SDA inputs
	//
	// module body
	//

	// whenever the slave is not ready it can delay the cycle by pulling SCL low

	// generate bus status controller
	reg dSCL, dSDA;
	reg sta_condition;
	reg sto_condition;

	// synchronize SCL and SDA inputs
	// reduce metastability risc
	always @(posedge clk)
	  if (!rst_)
	    begin
	        sSCL <= 1'b1;
	        sSDA <= 1'b1;

	        dSCL <= 1'b1;
	        dSDA <= 1'b1;
	    end
	  else
	    begin
	        sSCL <= scl_i;
	        sSDA <= sda_i;

	        dSCL <= sSCL;
	        dSDA <= sSDA;
	    end

	// detect start condition => detect falling edge on SDA while SCL is high
	// detect stop condition => detect rising edge on SDA while SCL is high
	always @(posedge clk)
	  if (!rst_)
	    begin
	        sta_condition <= 1'b0;
	        sto_condition <= 1'b0;
	    end
	  else
	    begin
	        sta_condition <= ~sSDA &  dSDA & sSCL;
	        sto_condition <=  sSDA & ~dSDA & sSCL;
	    end

  always@(posedge clk)
    if(!rst_) stop <= 1'b1;
    else if(sta_condition) stop <= 1'b0;
    else if(sto_condition) stop <= 1'b1;
	// generate i2c bus busy signal
	always @(posedge clk)
	  if (!rst_)
	    busy <= 1'b0;
	  else
	    busy <= (sta_condition | busy) & ~sto_condition;

	// generate dout signal (store SDA on rising edge of SCL)
	always @(posedge clk)
	  if(sSCL & ~dSCL)
	    dout <= sSDA;

  reg first_rise;
  always@(posedge clk)
    if(!rst_) first_rise <= 1'b0;
    else if(sSCL & ~dSCL) first_rise <= 1'b1;
    else if(sto_condition) first_rise <= 1'b0;
	// generate statemachine

	always @(posedge clk)
	  if (!rst_)
	    begin
	        cmd_ack <= 1'b0;
	        sda_oen <= 1'b1;
	    end
	  else
	    begin
	        cmd_ack   <= 1'b0; // default no command acknowledge + assert cmd_ack only 1clk cycle
          sda_oen  <= (cmd==`I2C_CMD_WRITE) ? din : 1'b1;
	        if ((~sSCL & dSCL) & first_rise)
	                cmd_ack <= 1'b1;
	    end


endmodule
