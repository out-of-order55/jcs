`include "../config.v"

module I2C_TOP (
    input        apb_pclk,
    input        apb_prstn,
    input        apb_psel,
	input  [2:0] apb_paddr,
	input        apb_pwrite,
    input        apb_penable,
    input  [7:0] apb_pwdata,
    output [7:0] apb_prdata,

	inout        I2C_SCL,
	inout        I2C_SDA,

	output       i2c_int
);
	
	wire                scl_i;
	wire                scl_o;
	wire                scl_oen;
	wire                sda_i;
	wire                sda_o;
	wire                sda_oen;

	I2C_IOBUF pad_I2C_SCL(.IO(I2C_SCL), .T(scl_oen), .I(scl_o), .O(scl_i));
	I2C_IOBUF pad_I2C_SDA(.IO(I2C_SDA), .T(sda_oen), .I(sda_o), .O(sda_i));

	//
	// variable declarations
	//

	// registers
    reg  [15:0] prer; // clock prescale register
	reg  [ 7:0] ctr;  // control register
	reg  [ 7:0] txr;  // transmit register
	wire [ 7:0] rxr_master; // receive register
	wire [ 7:0] rxr_slave;  // receive register
	reg  [ 7:0] cr;   // command register
	wire [ 7:0] sr;   // status register
    reg  [ 7:0] buslock_top; // bus lock cycles top {buslock_top,x'b0}
	reg  [ 7:0] slave_addr; // slave address when controller in slave mode

	// done signal: command completed, clear command register
	wire done_master;
	wire done_slave;

    wire slave_addressed;
    wire slave_rw;

	// core enable signal
	wire core_en;
	wire ien;
	wire master_slave;
    wire txr_ok,rxr_ok;
    wire buslock_check_en;
    wire slv_autoreset_en;

	// status register signals
	wire irxack_master;
	wire irxack_slave;
	reg  rxack;       // received aknowledge from slave
	reg  tip;         // transfer in progress
	reg  irq_flag;    // interrupt pending flag
	wire busy_master; // bus busy (start signal detected)
	wire busy_slave;  // bus busy (start signal detected)
	wire i2c_al;      // i2c bus arbitration lost
	reg  al;          // status register arbitration lost bit
	
	wire we = apb_psel & apb_pwrite & apb_penable;

    wire sda_oen_master;
    wire sda_oen_slave;
    wire scl_oen_master;
    wire scl_oen_slave;

	//
	// module body
	//
	reg [7:0] rdata;
	always @(apb_paddr or prer or ctr or rxr_master or rxr_slave or master_slave or sr or 
		buslock_top or cr or slave_addr)
	begin
		case (apb_paddr)// synopsys parallel_case
			3'b000: rdata = prer[ 7:0];
			3'b001: rdata = prer[15:8];
			3'b010: rdata = ctr;
			3'b011: rdata = master_slave ? rxr_master : rxr_slave;// write is transmit register (txr)
			3'b100: rdata = sr;// write is command register (cr)
			3'b101: rdata = buslock_top;
			3'b110: rdata = cr;// ================================================================ 
			3'b111: rdata = slave_addr;
		endcase
	end
	assign apb_prdata = rdata;

	// generate registers
	always @(posedge apb_pclk)
		if (!apb_prstn) 
		begin
			prer <=  16'hffff;
			ctr  <=  8'h0;
			txr  <=  8'h0;
			slave_addr <= 8'b0;
			buslock_top <= 8'hff;
		end
		else if (we)
		begin
			case (apb_paddr) // synopsys parallel_case
				3'b000 : prer [ 7:0] <= apb_pwdata;
				3'b001 : prer [15:8] <= apb_pwdata;
				3'b010 : ctr         <= apb_pwdata;
				3'b011 : txr         <= apb_pwdata;
				3'b101 : buslock_top <= apb_pwdata;
				3'b111 : slave_addr  <= apb_pwdata;
				default: ;
			endcase
		end
        else
        begin
            ctr[4:3] <= 2'b0;
        end

	// generate command register (special case)
	always @(posedge apb_pclk)
		if (~apb_prstn) 
		begin
			cr <= 8'h0;
		end
		else if (we & core_en & (apb_paddr == 3'b100)) 
			cr <= apb_pwdata;
		else 
		begin
			// clear command bits when done or when aribitration lost
			if ((master_slave & done_master) | (~master_slave & done_slave) | i2c_al) 
			// i2c_al indicates that the master loses arbitration
			begin 
				cr[7:4] <= 4'h0; cr[2] <= 1'b0; 
				cr[1] <= 1'b0;// reserved bits
				cr[0] <= 1'b0;// clear IRQ_ACK bit
			end
		end

	// decode command register
	wire sta     = cr[7];
	wire sto     = cr[6];
	wire rd      = cr[5];
	wire wr      = cr[4];
	wire ack     = cr[3];
    wire recover = cr[2];
	wire iack    = cr[0];

	// decode control register
	assign core_en          = ctr[7];
	assign ien              = ctr[6];
    assign master_slave     = ctr[5];
    assign txr_ok           = ctr[4];
    assign rxr_ok           = ctr[3];
    assign buslock_check_en = ctr[1];
    assign slv_autoreset_en = ctr[0];

	// hookup byte controller block
	i2c_master_byte_ctrl master_byte_controller 
	(
		.clk      (apb_pclk            ),
		.rstn     (apb_prstn           ),
		.ena      (core_en         ),
		.clk_cnt  (prer            ),
		.start    (sta             ),
		.stop     (sto             ),
		.read     (rd              ),
		.write    (wr              ),
        .recover  (recover         ),
		.ack_in   (ack             ),
		.din      (txr             ),
		.done     (done_master     ),
		.ack_out  (irxack_master   ),
		.dout     (rxr_master      ),
		.i2c_busy (busy_master     ),
		.i2c_al   (i2c_al          ),
		.scl_i    (scl_i           ),
		.scl_oen  (scl_oen_master  ),
		.sda_i    (sda_i           ),
		.sda_oen  (sda_oen_master  ) 
	);

    wire buslock;
    wire slv_autoreset = slv_autoreset_en & buslock;

	/*
	i2c_slave_byte_ctrl slave_byte_controller
	(
		.clk              ( apb_pclk            ),
		.rstn             ( apb_prstn           ),
		.ena              ( core_en         ),
		.ack_in           ( ack             ),
		.txr_ok           ( txr_ok          ),
		.rxr_ok           ( rxr_ok          ),
        .slave_addr		  (slave_addr       ),
		.din              ( txr             ),
		.cmd_ack          ( done_slave      ),
		.ack_out          ( irxack_slave    ),
		.dout             ( rxr_slave       ),
		.i2c_busy         ( busy_slave      ),
		.scl_i            ( scl_i           ),
		.scl_oen          ( scl_oen_slave   ),
		.sda_i            ( sda_i           ),
		.sda_oen          ( sda_oen_slave   ),
        .slv_autoreset    (slv_autoreset	),
        .slave_addressed  (slave_addressed  ),
        .slave_rw 		  (slave_rw         )
	);
	*/

    assign scl_o = 1'b0;
    assign sda_o = 1'b0;
    assign sda_oen = master_slave ? sda_oen_master : sda_oen_slave;
    assign scl_oen = master_slave ? scl_oen_master : scl_oen_slave;
	
	// status register block + interrupt request signal
	always @(posedge apb_pclk)
        if (!apb_prstn)  
		begin
			al       <= 1'b0;
			rxack    <= 1'b0;
			tip      <= 1'b0;
			irq_flag <= 1'b0;
		end
		else 
		begin
			al       <= i2c_al | (al & ~sta);
			rxack    <= master_slave ? irxack_master : irxack_slave;
			tip      <= (rd | wr | recover);
			irq_flag <= ((master_slave & done_master) | (~master_slave & done_slave) | i2c_al | irq_flag) 
				& ~iack; // 'irq_flag' is always generated once 'irq_flag' becomes 1, until iack is 1.
			// iack is decided by input, can not automatically reset to zero
		end

	// generate interrupt request signals
	assign i2c_int = irq_flag && ien;// interrupt signal is only generated when IEN (interrupt enable bit is set)

    wire sda_i_sync;
    wire scl_i_sync;
    i2c_sync_module #(1) i_sda_i_sync(.async_in(sda_i), .clock(apb_pclk), .sync_out(sda_i_sync));
    i2c_sync_module #(1) i_scl_i_sync(.async_in(scl_i), .clock(apb_pclk), .sync_out(scl_i_sync));

    reg [23:0] buslock_cnt;
    always@(posedge apb_pclk)
		if(~apb_prstn || ~buslock_check_en)     
			buslock_cnt <= 'b0;
		else if(scl_i_sync & ~sda_i_sync)// clock line always pulles up and data line always pulles down
		begin
			if(buslock_cnt != {buslock_top, 16'b0})
				buslock_cnt <= buslock_cnt + 1'b1;
		end
		else
			buslock_cnt <= 'b0;

    assign buslock = buslock_check_en & (buslock_cnt == {buslock_top, 16'b0});

	// assign status register bits
	assign sr[7]   = rxack;
	assign sr[6]   = master_slave ? busy_master : busy_slave;
	assign sr[5]   = al;
	assign sr[4]   = slave_addressed;
    assign sr[3]   = slave_rw;
    assign sr[2]   = buslock;
	assign sr[1]   = tip;
	assign sr[0]   = irq_flag;

endmodule


module i2c_sync_module(async_in, clock, sync_out);

	parameter WIDTH = 1;
	parameter NEGEDGE = 1;

	input              clock;
	input  [WIDTH-1:0] async_in;
	output [WIDTH-1:0] sync_out;

	reg [WIDTH-1:0]    sync_stage0;
	reg [WIDTH-1:0]    sync_stage1;

	generate
		if (NEGEDGE) begin: stage0_negedge
			always @(negedge clock) begin // falling edge
				sync_stage0 <= async_in;
			end
		end 
		else begin: stage0_posedge
			always @(posedge clock) begin // rising edge
				sync_stage0 <= async_in;
			end
		end
	endgenerate

	always @(posedge clock) begin // rising edge --> reduce sync delay
		sync_stage1 <= sync_stage0;
	end
	assign sync_out = sync_stage1;

endmodule // i2c_sync_module


