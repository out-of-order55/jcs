`define I2C_CMD_NOP   4'b0000
`define I2C_CMD_START 4'b0001
`define I2C_CMD_STOP  4'b0010
`define I2C_CMD_WRITE 4'b0100
`define I2C_CMD_READ  4'b1000
module i2c_slave_byte_ctrl (
	clk, rst_, ena, slave_addr, din, txr_ok, rxr_ok, ack_in, cmd_ack,
 ack_out, dout, i2c_busy, scl_i, scl_oen, sda_i, sda_oen,
 slv_autoreset,
 slave_addressed, slave_rw );

	//
	// inputs & outputs
	//
	input clk;     // master clock
	input rst_;    // synchronous active high reset
	input ena;     // core enable signal

	// control inputs
  input [7:0] slave_addr;
	input [7:0] din;

  input txr_ok;
  input rxr_ok;
  input ack_in;
  output cmd_ack;
  reg cmd_ack;
	// status outputs
	output       ack_out;
	reg ack_out;
	output       i2c_busy;
	output [7:0] dout;

	// I2C signals
	input  scl_i;
	input  sda_i;
	output sda_oen;
	output scl_oen;

    input slv_autoreset;
  output slave_addressed;
  output slave_rw;
	//
	// Variable declarations
	//

	// statemachine
	parameter [4:0] ST_IDLE       = 5'b0_0000;
	parameter [4:0] ST_READ       = 5'b0_0001;
	parameter [4:0] ST_WRITE      = 5'b0_0011;
	parameter [4:0] ST_READ_ACK   = 5'b0_0010;
	parameter [4:0] ST_WRITE_ACK  = 5'b0_0110;
	parameter [4:0] ST_WAIT_TXR   = 5'b0_0111;
	parameter [4:0] ST_WAIT_RXR   = 5'b0_0101;
	parameter [4:0] ST_WRITE_END  = 5'b0_0100;

	// signals for bit_controller
	reg  [3:0] core_cmd;
	reg        core_txd;
	wire       core_ack, core_rxd;

	// signals for shift register
	reg [7:0] sr; //8bit shift register
	reg       shift, ld;

	// signals for state machine
	wire       go;
	reg  [2:0] dcnt;
	wire       cnt_done;

	//
	// Module body
	//
wire stop,start;
wire stop_from_bus;
assign stop = stop_from_bus | slv_autoreset;
	// hookup bit_controller

	i2c_slave_bit_ctrl bit_controller (
		.clk     ( clk      ),
		.rst_    ( rst_     ),
		.ena     ( ena      ),
		.cmd     ( core_cmd ),
		.cmd_ack ( core_ack ),
    .stop    ( stop_from_bus),
		.busy    ( i2c_busy ),
		.din     ( core_txd ),
		.dout    ( core_rxd ),
		.scl_i   ( scl_i    ),
		.sda_i   ( sda_i    ),
		.sda_oen ( sda_oen  ),
	  .sta_condition (start)
  );

	// generate go-signal
//	assign go = (read | write | stop) & ~cmd_ack;

	// assign dout output to shift-register
	assign dout = sr;

	// generate shift register
	always @(posedge clk )
	  if ( !rst_ )
	    sr <= 8'h0;
	  else if (ld)
	    sr <= din;
	  else if (shift)
	    sr <= {sr[6:0], core_rxd};

	// generate counter
	always @(posedge clk)
	  if (!rst_)
	    dcnt <= 3'h0;
	  else if (ld)
	    dcnt <= 3'h7;
	  else if (shift)
	    dcnt <= dcnt - 3'h1;

	assign cnt_done = ~(|dcnt);

reg flag,flag_dly;
reg addr_flag;
always@(posedge clk)
  if(!rst_) flag_dly <= 1'b1;
  else flag_dly <= flag;

  reg slave_addressed;
always@(posedge clk)
  if(!rst_ | stop) slave_addressed <= 1'b0;
  else if(flag_dly & !flag) slave_addressed <= 1'b1;
  else if(slave_addressed & cmd_ack) slave_addressed <= 1'b0;

	reg [4:0] c_state;
assign slave_rw = c_state ==  ST_WRITE | c_state == ST_WRITE_ACK | c_state == ST_WAIT_TXR | c_state == ST_WRITE_END;


	//
	// state machine
	//
	always @(posedge clk)
        if ( !rst_ || ~ena)
	   begin
	       core_cmd <= `I2C_CMD_NOP;
	       core_txd <= 1'b0;
	       shift    <= 1'b0;
	       ld       <= 1'b0;
	       c_state  <= ST_IDLE;
	       ack_out  <= 1'b0;
         cmd_ack  <= 1'b0;
        flag <= 1'b1;
        addr_flag <= 1'b1;
	   end
	else
	  begin
	      // initially reset all signals
//	      core_txd <= sr[7];
	      shift    <= 1'b0;
        cmd_ack  <= 1'b0;
	      ld       <= 1'b0;

	      case (c_state) // synopsys full_case parallel_case
	        ST_IDLE:
	            begin
                  if(start) addr_flag <= 1'b1;
                  else
                  if(~stop & addr_flag) begin
	                      c_state  <= ST_READ;
	                      core_cmd <= `I2C_CMD_READ;
	                ld <= 1'b1;
                  flag <= 1'b1;
                  end
	            end

	        ST_WRITE:
            if(stop)begin
                c_state <= ST_IDLE;
                core_cmd<= `I2C_CMD_READ;
            end
            else
	          if (core_ack)
	            begin
		     if (cnt_done)
	              begin
	                  c_state  <= ST_WRITE_ACK;
	                  core_cmd <= `I2C_CMD_READ;
	              end
	            else
	              begin
	                  c_state  <= ST_WRITE;       // stay in same state
	                  core_cmd <= `I2C_CMD_WRITE; // write next bit
	      core_txd <= sr[6];
	                  shift    <= 1'b1; // ? so not all bit shifted ?
	              end
		    end

	        ST_READ:
            if(stop)begin
                c_state <= ST_IDLE;
                core_cmd<= `I2C_CMD_READ;
            end
            else
	          if (core_ack)
	            begin
	                if (cnt_done)
	                  begin
                        core_txd <= ~addr_flag & ~flag ? ack_in : (sr[6:0]==slave_addr[6:0]) ? 1'b0 : 1'b1 ;
	                      c_state  <= ST_READ_ACK;
	                      core_cmd <= `I2C_CMD_WRITE;
	                  end
	                else
	                  begin
	                      c_state  <= ST_READ;       // stay in same state
	                      core_cmd <= `I2C_CMD_READ; // read next bit
	                  end

                    shift    <= 1'b1;
	            end

	        ST_READ_ACK:
            if(stop) begin
                c_state <= ST_IDLE;
                core_cmd <= `I2C_CMD_READ;
            end
            else
	          if (core_ack)
	            begin
                if(addr_flag & (sr[7:1]==slave_addr[6:0]))// addr cycle
                  begin
                  addr_flag <= 1'b0; 
                  flag <= 1'b0;
                  cmd_ack <= 1'b1;
	                if(~sr[0]) // master write, i slave read
	                 begin
                      if(rxr_ok) begin
	                     c_state  <= ST_READ;
	                     core_cmd <= `I2C_CMD_READ;
                      end
                      else begin
                        c_state <= ST_WAIT_RXR;
                        core_cmd<= `I2C_CMD_READ;
                      end
	                 end
	               else // master read,
	                 begin
                      if(txr_ok) begin
	                     c_state  <= ST_WRITE;
	                     core_cmd <= `I2C_CMD_WRITE;
	      core_txd <= din[7];
                       ld <= 1'b1;
                        end
                      else begin
                        c_state <= ST_WAIT_TXR;
                        core_cmd<= `I2C_CMD_READ;
                      end
	                 end
                  end
                else
                if(addr_flag & !(sr[7:1]==slave_addr[6:0]))
                  begin
                    addr_flag <= 1'b0;
                    c_state <= ST_IDLE;
                    core_cmd<= `I2C_CMD_READ;
                  end
                else begin
                cmd_ack <= 1'b1;
                if(rxr_ok)
                begin
	                     c_state  <= ST_READ;
	                     core_cmd <= `I2C_CMD_READ;
                end
                else
                begin
                      c_state <= ST_WAIT_RXR;
                      core_cmd <= `I2C_CMD_READ;
                end
                end
//                  if(core_rxd)
//                   begin
//                      c_state <= ST_IDLE;
//                      core_cmd<= `I2C_CMD_READ;
//                   end
	                 // assign ack_out output to bit_controller_rxd (contains last received bit)
	                 ack_out <= core_rxd;

//	                 core_txd <= 1'b1;
	             end
//	           else
	//             core_txd <= ack_in; // ?

	        ST_WRITE_ACK:
            if(stop)begin
                c_state <= ST_IDLE;
                core_cmd<= `I2C_CMD_READ;
            end
            else
	          if (core_ack)
	            begin
                if(core_rxd == 1'b1)// not ack
                begin
	                c_state  <= ST_WRITE_END;
	                core_cmd <= `I2C_CMD_READ;
                end
                else if(txr_ok)
                begin
	                c_state  <= ST_WRITE;
	                core_cmd <= `I2C_CMD_WRITE;
	      core_txd <= din[7];
                  ld <= 1'b1;
                end
                else
                begin
                  c_state <= ST_WAIT_TXR;
                  core_cmd<= `I2C_CMD_READ;
                end
                ack_out <= core_rxd;
                cmd_ack <= 1'b1;
	            end
  //          else core_txd <= ack_in; // ??
          ST_WAIT_TXR:
            if(stop)begin
                c_state <= ST_IDLE;
                core_cmd<= `I2C_CMD_READ;
            end
            else
            if(txr_ok) 
            begin
              c_state <= ST_WRITE;
              core_cmd <= `I2C_CMD_WRITE;
	      core_txd <= din[7];
              ld <= 1'b1;
            end

          ST_WAIT_RXR:
            if(stop)begin
                c_state <= ST_IDLE;
                core_cmd<= `I2C_CMD_READ;
            end
            else
            if(rxr_ok)
            begin
              c_state <= ST_READ;
              core_cmd<= `I2C_CMD_READ;
            end

          ST_WRITE_END:
            if(stop)begin
                c_state <= ST_IDLE;
                core_cmd<= `I2C_CMD_READ;
            end
            else
            if(txr_ok)
            begin
              c_state <= ST_IDLE;
              core_cmd <= `I2C_CMD_READ;
            end
               default: begin
                c_state <= ST_IDLE;
                core_cmd<= `I2C_CMD_READ;
            end
	      endcase
	  end
wire scl_oen_r = (c_state==ST_WAIT_TXR) | (c_state==ST_WAIT_RXR) | (c_state==ST_WRITE_END) ? 1'b0 : 1'b1; // clock strech
reg [1:0] scl_oen_delay;
always@(posedge clk)
  if(!rst_) scl_oen_delay <= 2'h3;
  else scl_oen_delay <= {scl_oen_delay[0],scl_oen_r}; 
assign scl_oen = scl_oen_delay[1];

endmodule
