`include "../config.v"

module HPET_TOP (
	input        apb_pclk,
	input        apb_prstn,
	input        apb_psel,
	input [3:0]  apb_paddr,
	input        apb_pwrite,
	input        apb_penable,
	input [31:0] apb_pwdata,
	output[31:0] apb_prdata,

	output       int_o
);
	
	wire we = apb_penable & apb_psel & apb_pwrite;
	wire re = apb_penable & apb_psel &~apb_pwrite;

	reg  start, int_en, periodic;
	reg  [31:0] count, compare, step;
	wire int_trig;

	always @(posedge apb_pclk)
		if (~apb_prstn) 
		begin
			start    <= 1'b0;
			int_en   <= 1'b0;
			periodic <= 1'b0;
		end
		else if (we && apb_paddr == `HPET_CFG) 
		begin
			start    <= apb_pwdata[0];
			int_en   <= apb_pwdata[1];
			periodic <= apb_pwdata[2];
		end

	always @(posedge apb_pclk)
		if (~apb_prstn) count <= 32'h0;
		else if (we && apb_paddr == `HPET_CNT && ~start) count <= apb_pwdata;
		else if (start) count <= count + 1'b1;
		else if (start == 0) count <= 1'b0;

	always @(posedge apb_pclk)
		if (~apb_prstn) compare <= 32'hffffffff;
		else if (we && apb_paddr == `HPET_CMP && ~start) compare <= apb_pwdata;
		else if (periodic & int_trig) compare <= compare + step;

	always @(posedge apb_pclk)
		if (~apb_prstn) step <= 32'h0;
		else if (we && apb_paddr == `HPET_STP && ~start) step <= apb_pwdata;
		
	assign int_trig = (count == compare) && start;

	reg int_r;
	always @(posedge apb_pclk)
		if (~apb_prstn) int_r <= 1'b0;
		else if (we && apb_paddr == `HPET_CFG && apb_pwdata[8]) int_r <= 1'b0;// write 1 to clear the interrupt flag bit
		else if (int_trig) int_r <= 1'b1;

	assign int_o = int_r & int_en;

	reg  [31:0]     rdata;
	always @(*) begin
		if (~apb_psel | apb_pwrite)
			rdata = 32'b0;
		else if (re)
		begin
			case (apb_paddr)
				`HPET_CFG: rdata = {23'b0, int_r, 5'b0, periodic, int_en, start};
				`HPET_CNT: rdata = count;
				`HPET_CMP: rdata = compare;
				`HPET_STP: rdata = step;
			endcase
		end
	end

	assign apb_prdata = rdata;

endmodule


