module i2c_master_byte_ctrl (
	clk, 
	rstn, 
	ena, 
	clk_cnt, 
	start, 
	stop, 
	read, 
	write, 
	recover, 
	ack_in, 
	din,
	done, 
	ack_out, 
	dout, 
	i2c_busy, 
	i2c_al, 
	scl_i, 
	scl_oen, 
	sda_i, 
	sda_oen
);

	//
	// inputs & outputs
	//
	input clk;     // master clock
	input rstn;    // active low
	input ena;     // core enable signal

	input [15:0] clk_cnt; // 4x SCL

	// control inputs
	input       start;
	input       stop;
	input       read;
	input       write;
    input       recover;
	input       ack_in;
	input [7:0] din;

	// status outputs
	output       done;
	reg done;
	output       ack_out;
	reg ack_out;
	output       i2c_busy;
	output       i2c_al;
	output [7:0] dout;

	// I2C signals
	input  scl_i;
	output scl_oen;
	input  sda_i;
	output sda_oen;

	//
	// Variable declarations
	//

	// statemachine
	parameter ST_IDLE    = 3'h0;// 空闲状态
	parameter ST_START   = 3'h1;// 开始状态
	parameter ST_READ    = 3'h2;// 读状态
	parameter ST_WRITE   = 3'h3;// 写状态
	parameter ST_ACK     = 3'h4;// 响应状态
	parameter ST_STOP    = 3'h5;// 停止状态
	parameter ST_RECOVER = 3'h6;// 总线死锁恢复状态

	// signals for bit_controller
	reg  [3:0] core_cmd;
	reg        core_txd;
	wire       core_ack, core_rxd;

	// signals for shift register
	reg [7:0] sr;// 8bit shift register
	reg       shift, ld;
    reg [3:0] ld_value;

	// signals for state machine
	wire       go;
	reg  [3:0] dcnt;
	wire       cnt_done;
    wire       clk_en;

	//
	// Module body
	//
    reg im_busy;

	// hookup bit_controller
	i2c_master_bit_ctrl bit_controller (
		.clk        (clk        ),
		.rstn       (rstn       ),
        .clk_en     (clk_en     ),
		
		.ena        (ena        ),
		.clk_cnt    (clk_cnt    ),
		.cmd        (core_cmd   ),
		.cmd_ack    (core_ack   ),
		// whenever a state is completed, core_ack is 1, otherwise core_ack is 0.
		.busy       (i2c_busy   ),
        .fsm_busy_i (im_busy    ),
		.al         (i2c_al     ),
		.din        (core_txd   ),
		.dout       (core_rxd   ),
		.scl_i      (scl_i      ),
		.scl_oen    (scl_oen    ),
		.sda_i      (sda_i      ),
		.sda_oen    (sda_oen    )
		// 'din' is the input data from apb. one bit of data('sr[7]') will be inputed every clk edge.
		// 'dout' is the output data, corresponding to the 'sda_i', will go to apb.
		// 'scl_oen' is the output clk of i2c.
		// 'sda_i' is the input data of i2c. 
		// 'sda_oen' decide the output data of i2c, corresponding to the 'din'. when 'sda_oen' is 1, 
	);

	// generate go-signal
	assign go = (read | write | stop) & ~done & clk_en;
	// do not use

	// assign dout output to shift-register
	assign dout = sr;

	// generate shift register
	always @(posedge clk)
		if (!rstn)
			sr <= 8'h0;
		else if (ld)
			sr <= din;
		else if (shift)
			sr <= {sr[6:0], core_rxd};
			// 'sr[7]' changes when shift = 1, namely, when write or read complete.

	// generate counter
	always @(posedge clk)
		if (!rstn)
			dcnt <= 3'h0;
		else if (ld)
			dcnt <= ld_value;
		else if (shift)
			dcnt <= dcnt - 3'h1;

	assign cnt_done = ~(|dcnt);

    //
    // new state machine
    //
    reg [2:0] c_state;
    reg [2:0] next_c_state;
    
    always @(posedge clk)
		if(~rstn | i2c_al) c_state <= ST_IDLE;
		else c_state <= next_c_state;

    always @(posedge clk)
		if(~rstn | i2c_al) im_busy <= 1'b0;
		else if((c_state == ST_START) & core_ack) im_busy <= 1'b1;
		else if((c_state == ST_STOP) & core_ack)  im_busy <= 1'b0;

    always @(*) begin
		next_c_state = c_state;
		case(c_state)
			ST_IDLE :
					if(clk_en)
						if(start) begin
							if(~i2c_busy | im_busy)
								// im_busy is useful?
								next_c_state = ST_START;// if busy, wait; but allowing repeat start
						end
						else if(recover)    next_c_state = ST_RECOVER;
						else if(read)       next_c_state = ST_READ;
						else if(write)      next_c_state = ST_WRITE;
						else if(stop)       next_c_state = ST_STOP;
			ST_START:
					if(core_ack)
						if(read)            next_c_state = ST_READ;
						else if(write)      next_c_state = ST_WRITE;
			ST_READ :
					if(core_ack)
						if(cnt_done)        next_c_state = ST_ACK;
			ST_WRITE:
					if(core_ack)
						if(cnt_done)        next_c_state = ST_ACK;
			ST_ACK  :
					if(core_ack)
						if(stop)            next_c_state = ST_STOP;
						else                next_c_state = ST_IDLE;
			ST_STOP :
					if(core_ack)            next_c_state = ST_IDLE;
			ST_RECOVER:
					if(core_ack & cnt_done) 
											next_c_state = ST_STOP;
						
			default :                       next_c_state = ST_IDLE;
		endcase
	end

	wire st_idle     = c_state == ST_IDLE   ;
	wire st_start    = c_state == ST_START  ;
	wire st_read     = c_state == ST_READ   ;
	wire st_write    = c_state == ST_WRITE  ;
	wire st_ack      = c_state == ST_ACK    ;
	wire st_stop     = c_state == ST_STOP   ;
	wire st_recover  = c_state == ST_RECOVER;
	wire nst_idle    = next_c_state == ST_IDLE   ;
	wire nst_start   = next_c_state == ST_START  ;
	wire nst_read    = next_c_state == ST_READ   ;
	wire nst_write   = next_c_state == ST_WRITE  ;
	wire nst_ack     = next_c_state == ST_ACK    ;
	wire nst_stop    = next_c_state == ST_STOP   ;
	wire nst_recover = next_c_state == ST_RECOVER;

	reg [4:0] toACK_state;

    always @(posedge clk) begin
		if(~rstn || i2c_al)         toACK_state <= ST_IDLE;
		else if(nst_ack & ~st_ack)  toACK_state <= c_state;// toACK_state <= ST_READ or ST_WRITE
	end

    always @(*) begin
        shift    = (st_read | st_write | st_recover) & core_ack;
        ld       = (st_idle & (nst_read | nst_write | nst_recover)) | (st_start & core_ack);
		
		/*
			in two cases, ld = 1.
		*/
        ld_value = (st_idle & nst_recover) ? 4'h8 : 4'h7;
        // ?
		done     = ~st_idle & nst_idle;
        core_txd = st_ack ? ack_in : sr[7];
        core_cmd =  st_idle       ? `I2C_CMD_NOP      :
                    st_recover    ? `I2C_CMD_READ     :
                    st_read       ? `I2C_CMD_READ     :
                    st_write      ? `I2C_CMD_WRITE    :
                    st_start      ? `I2C_CMD_START    :
                    st_stop       ? `I2C_CMD_STOP     :
		(toACK_state == ST_READ)  ? `I2C_CMD_WRITE    :
		(toACK_state == ST_WRITE) ? `I2C_CMD_READ     :
									`I2C_CMD_NOP      ;
    end

    always @(posedge clk)
    if (~rstn || i2c_al)         ack_out <= 1'b0;
    else if (st_ack & core_ack)  ack_out <= core_rxd;

endmodule
