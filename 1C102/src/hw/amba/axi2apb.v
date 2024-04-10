/*
NOTES:
1. Axi2apb_bridge supports 32bit/8bit apb devices(apb_word_trans determines this).
2. Axi2apb_bridge only supports axi_len == 0 transfer and 
    the axi_size not more than 3'b10(that is only byte/half/word is supported).
3. When a axi bus transfer access a 32bit width apb devices, the apb_address's word alignment depends on the 
    attibute of axi_araddr/axi_awaddr. Axi2apb_bidge doesn't ganrantee word alignment.    
*/

`include "../config.v"

module axi2apb_bridge (
	input                   clk,
	input                   rst_n,
	input [`LID-1:0]        axi_s_awid,
	input [`Lawaddr-1:0]    axi_s_awaddr,
	input [3:0]             axi_s_awlen,
	input [2:0]             axi_s_awsize,
	input [1:0]             axi_s_awburst,
	input [1:0]             axi_s_awlock,
	input [3:0]             axi_s_awcache,
	input [2:0]             axi_s_awprot,
	input                   axi_s_awvalid,
	output                  axi_s_awready,

	input [`LID-1:0]        axi_s_wid,
	input [31:0]            axi_s_wdata,
	input [3:0]             axi_s_wstrb,
	input                   axi_s_wlast,
	input                   axi_s_wvalid,
	output reg              axi_s_wready,

	output[`LID-1:0]        axi_s_bid,
	output[1:0]             axi_s_bresp,
	output                  axi_s_bvalid,
	input                   axi_s_bready,

	input [`LID-1:0]        axi_s_arid,
	input [`Laraddr-1:0]    axi_s_araddr,
	input [3:0]             axi_s_arlen,
	input [2:0]             axi_s_arsize,
	input [1:0]             axi_s_arburst,
	input [1:0]             axi_s_arlock,
	input [3:0]             axi_s_arcache,
	input [2:0]             axi_s_arprot,
	input                   axi_s_arvalid,
	output                  axi_s_arready,

	output[`LID-1:0]        axi_s_rid,
	output[31:0]            axi_s_rdata,
	output[1:0]             axi_s_rresp,
	output                  axi_s_rlast,
	output                  axi_s_rvalid,
	input                   axi_s_rready,

	output                  apb_valid_cpu,

	output                  apb_clk,
	output                  apb_reset_n,
	output reg              reg_psel,
	output reg              reg_enable,
	output                  reg_rw,
	output[`ADDR_APB-1:0]   reg_addr,

	output[`DATA_APB-1:0]   reg_datai,
	input [`DATA_APB-1:0]   reg_datao,
	input                   reg_ready_1
);

	reg busy;
	reg W_R;
	reg [`Lawaddr-1:0] addr;
	reg [2:0] size;
	reg [`LID-1:0] id;
	wire [1:0] waddr;
	reg [1:0] waddr_r;
	assign apb_clk = clk;
	assign apb_reset_n = rst_n;
	assign reg_rw = W_R;
	assign reg_addr = reg_rw ? {addr[`ADDR_APB-1:2],waddr_r}:addr[`ADDR_APB-1:0]; 
	assign apb_valid_cpu = busy | axi_s_awvalid | axi_s_arvalid;

	assign axi_s_awready = ~busy & (~W_R | ~axi_s_arvalid);
	assign axi_s_arready = ~busy & ( W_R | ~axi_s_awvalid); 

	wire aw_enter = axi_s_awvalid & axi_s_awready;
	wire w_enter  = axi_s_wvalid & axi_s_wready & axi_s_wlast; 
	wire b_retire = axi_s_bvalid & axi_s_bready;
	wire ar_enter = axi_s_arvalid & axi_s_arready;
	wire r_retire = axi_s_rvalid & axi_s_rready & axi_s_rlast;

	always@(posedge clk)
		if(~rst_n) busy <= 1'b0;
		else if((aw_enter) | (ar_enter)) busy <= 1'b1;
		else if((b_retire) | (r_retire)) busy <= 1'b0;

	always@(posedge clk)
		if(~rst_n) W_R <= 1'b1;
		else if(aw_enter | ar_enter) W_R <= aw_enter;

	always@(posedge clk)
		if(~rst_n) 
		begin
			addr <= 'b0;
			size <= 2'b0;
			id <= 'h0;
		end
		else if(aw_enter|ar_enter) 
		begin
			addr <= aw_enter ? axi_s_awaddr : axi_s_araddr;
			size <= aw_enter ? axi_s_awsize : axi_s_arsize;
			id   <= aw_enter ? axi_s_awid : axi_s_arid;
		end

	wire [31:0] s_wdata;
	assign s_wdata = {{8{axi_s_wstrb[ 3]}}&axi_s_wdata[ 31: 24],
					  {8{axi_s_wstrb[ 2]}}&axi_s_wdata[ 23: 16],
					  {8{axi_s_wstrb[ 1]}}&axi_s_wdata[ 15:  8],
					  {8{axi_s_wstrb[ 0]}}&axi_s_wdata[  7:  0]};
	wire [31:0] wdata;

	assign waddr = axi_s_wstrb[0] ? 2'h0 :
				   axi_s_wstrb[1] ? 2'h1 :
				   axi_s_wstrb[2] ? 2'h2 :
				   axi_s_wstrb[3] ? 2'h3 :
									2'h0;

	assign wdata = waddr[1:0] == 2'h0 ? s_wdata[31: 0] :
				   waddr[1:0] == 2'h1 ? { 8'h0,s_wdata[31: 8]} :
				   waddr[1:0] == 2'h2 ? {16'h0,s_wdata[31:16]} :
										{24'h0,s_wdata[31:24]};

	reg [31:0] reg_datai_32;
	assign reg_datai = reg_datai_32;
	always@(posedge clk)
		if(~rst_n) reg_datai_32 <= 32'h0; 
		else if(w_enter) reg_datai_32 <= wdata; 

	always@(posedge clk)
		if(~rst_n) waddr_r <= 2'h0;
		else if(w_enter) waddr_r <= waddr;

	reg [2:0] state;
	reg [31:0] rdata;
	reg valid;

	always@(posedge clk or negedge rst_n)
		if(~rst_n)
		begin
			reg_psel <= 1'b0;
			reg_enable <= 1'b0;
			state <= 3'h0;
			valid <= 1'b0;
		end
		else 
		begin
			case (state)
				3'h0:    if(w_enter|ar_enter) begin reg_psel <= 1'b1; state <= 3'h1; end
				3'h1:    begin reg_enable <= 1'b1; state <= 3'h2; end
				3'h2:    if(reg_ready_1) begin reg_psel <= 1'b0; reg_enable <= 1'b0; state <= 3'h3; rdata <= reg_datao; valid <= 1'b1; end
				3'h3:    if(b_retire|r_retire) begin state <= 3'h0; valid <= 1'b0; end
				default: begin reg_psel <= 1'b0; reg_enable <= 1'b0; state <= 3'h0; end
			endcase
		end // else(~rst_n)



	assign axi_s_rlast = 1'b1;
	assign axi_s_rvalid = ~reg_rw & valid;
	assign axi_s_rid   = id;
	assign axi_s_rresp = 2'h0;
	assign axi_s_bresp = 2'h0;
	assign axi_s_bvalid = reg_rw & valid;
	assign axi_s_bid   = id;

	assign axi_s_rdata = ( addr[1:0] == 2'h0) ? {rdata            } :
						 ( addr[1:0] == 2'h1) ? {rdata[23:0], 8'h0} :
						 ( addr[1:0] == 2'h2) ? {rdata[15:0],16'h0} :
						 ( addr[1:0] == 2'h3) ? {rdata[ 7:0],24'h0} :
												32'h0 ;

	always@(posedge clk)
		if(~rst_n)
			axi_s_wready <= 1'b0;
		else if(aw_enter) axi_s_wready <= 1'b1;
		else if(w_enter) axi_s_wready <= 1'b0; 

endmodule


