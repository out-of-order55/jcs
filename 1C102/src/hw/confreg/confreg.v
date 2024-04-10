`include "../config.v"

module CONFREG (
    input             apb_pclk,
    input             apb_prstn,
    input             apb_psel,
	input [19:0]      apb_paddr,
	input             apb_pwrite,
    input             apb_penable,
    input [7:0]       apb_pwdata,
    output reg [7:0]  apb_prdata,

	input             timer_int,
	input             i2c_int,
	input             uart1_int,
    input             uart0_int,
    input             flash_int,
    input             spi_int,
    input             vpwm_int,
    input             dma_int,

    output            int_o
);
	
	wire we = apb_psel & apb_penable & apb_pwrite;
	wire re = apb_psel & apb_penable &~apb_pwrite;

	reg [7:0]  int_en;
	reg [7:0]  int_edge;
	reg [7:0]  int_pol;
	wire [7:0] int_out;

	always @(posedge apb_pclk)
	begin
		if (!apb_prstn)
		begin
			int_en  <= 8'b00000000;
			int_edge<= 8'b01000000;
			int_pol <= 8'b11111111;
		end 
		else if (we)
		begin
			case(apb_paddr)
				`INT_EN     : int_en    <= apb_pwdata;
				`INT_EDGE   : int_edge  <= apb_pwdata;
				`INT_POL    : int_pol   <= apb_pwdata;
				default : ;
			endcase
		end
	end

	wire [7:0] status_in = 8'b0;
	always @(*)
	begin
		case(apb_paddr)
			`INT_EN     : apb_prdata <= int_en;
			`INT_EDGE   : apb_prdata <= int_edge;
			`INT_POL    : apb_prdata <= int_pol;
			// `INT_CLR    : apb_prdata <= int_clr;
			// `INT_SET    : apb_prdata <= int_set;
			`INT_OUT    : apb_prdata <= int_out;
			`SRPROT     : apb_prdata <= status_in[7:0];
		default:  apb_prdata <= 8'b0;
		endcase
	end

	reg [1:0] vpwm_int_v;
	always @(posedge apb_pclk) vpwm_int_v[1:0] <= {vpwm_int_v[0], vpwm_int};

	wire [7:0] int_in = {dma_int, vpwm_int_v[1], spi_int, flash_int, uart0_int, uart1_int, i2c_int, timer_int};
	wire [7:0] int_clr = we && (apb_paddr == `INT_CLR) ? apb_pwdata : 8'b0;
	wire [7:0] int_set = we && (apb_paddr == `INT_SET) ? apb_pwdata : 8'b0;

	one_int_gen int0(.clk(apb_pclk),.rst(~apb_prstn), .int_en(int_en[0]),.int_edge(int_edge[0]), .int_pol(int_pol[0]),
						.int_in(int_in[0]), .int_set(int_set[0]),.int_clr ( int_clr[0]), .int_out(int_out[0]));
	one_int_gen int1(.clk(apb_pclk),.rst(~apb_prstn), .int_en(int_en[1]),.int_edge(int_edge[1]), .int_pol(int_pol[1]),
						.int_in(int_in[1]), .int_set(int_set[1]),.int_clr ( int_clr[1]), .int_out(int_out[1]));
	one_int_gen int2(.clk(apb_pclk),.rst(~apb_prstn), .int_en(int_en[2]),.int_edge(int_edge[2]), .int_pol(int_pol[2]),
						.int_in(int_in[2]), .int_set(int_set[2]),.int_clr ( int_clr[2]), .int_out(int_out[2]));
	one_int_gen int3(.clk(apb_pclk),.rst(~apb_prstn), .int_en(int_en[3]),.int_edge(int_edge[3]), .int_pol(int_pol[3]),
						.int_in(int_in[3]), .int_set(int_set[3]),.int_clr ( int_clr[3]), .int_out(int_out[3]));
	one_int_gen int4(.clk(apb_pclk),.rst(~apb_prstn), .int_en(int_en[4]),.int_edge(int_edge[4]), .int_pol(int_pol[4]),
						.int_in(int_in[4]), .int_set(int_set[4]),.int_clr ( int_clr[4]), .int_out(int_out[4]));
	one_int_gen int5(.clk(apb_pclk),.rst(~apb_prstn), .int_en(int_en[5]),.int_edge(int_edge[5]), .int_pol(int_pol[5]),
						.int_in(int_in[5]), .int_set(int_set[5]),.int_clr ( int_clr[5]), .int_out(int_out[5]));
	one_int_gen int6(.clk(apb_pclk),.rst(~apb_prstn), .int_en(int_en[6]),.int_edge(int_edge[6]), .int_pol(int_pol[6]),
						.int_in(int_in[6]), .int_set(int_set[6]),.int_clr ( int_clr[6]), .int_out(int_out[6]));
	one_int_gen int7(.clk(apb_pclk),.rst(~apb_prstn), .int_en(int_en[7]),.int_edge(int_edge[7]), .int_pol(int_pol[7]),
						.int_in(int_in[7]), .int_set(int_set[7]),.int_clr ( int_clr[7]), .int_out(int_out[7]));

	assign int_o = |int_out;

endmodule



module one_int_gen(clk, rst, int_en, int_edge, int_pol , int_in, int_out, int_clr, int_set);
	input  clk;
	input  rst;
	input  int_en;
	input  int_edge;
	input  int_pol;
	input  int_in;
	input  int_clr;
	input  int_set;
	output int_out;

	reg    int_delay;
	reg    int_lt;
	always @(posedge clk)
	begin
		if (rst)
			int_delay <= 1'b0;
		else
			int_delay <= int_in;
	end

	always @ (posedge clk)
	begin
		if (rst) int_lt <= 1'b0;
		else if (int_in != int_delay && int_in == int_pol) int_lt <= 1'b1;
		// detecting the edge of int_in
		else if (int_set)           int_lt <= 1'b1;
		else if (int_clr)           int_lt <= 1'b0;
	end

	wire   inv_int   =  ~(int_pol ^ int_in);// for INTC(dma, vpwm, ..., i2c, timer), int_pol defaults to 1
	wire   level_int = int_edge ? int_lt : inv_int;// for INTC, int_edge is 0, so level_int is always equal to inv_int
	assign int_out   = int_en & level_int;

endmodule


