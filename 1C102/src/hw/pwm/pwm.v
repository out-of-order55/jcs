`include "../config.v"

module apb_pwm (
    input           apb_pclk,
    input           apb_prstn,
    input           apb_psel,
    input  [31:0]   apb_paddr,
    input           apb_penable,
    input           apb_pwrite,
    input  [31:0]   apb_pwdata,
    output [31:0]   apb_prdata,

    output          PWM01
);

	reg [31:0]  	 div_freq_r;
	reg [31:0]		 comp_r;
	reg [31:0]		 state_r;

	wire [31:0] div_freq    = div_freq_r;
	wire [31:0] comp        = comp_r;
	wire [31:0] state       = state_r;
	wire start 				= state_r[0];

	wire we = apb_penable & apb_psel & apb_pwrite;
	wire re = apb_penable & apb_psel &~apb_pwrite;

	always @(posedge apb_pclk or negedge apb_prstn) 
	begin
		if (!apb_prstn) 
		begin
			div_freq_r <= 32'b0;
			comp_r <= 32'b0;
			state_r <= 32'b0;
		end 
		else if (we) 
		begin
			case (apb_paddr[7:0])
				8'h30: div_freq_r <= apb_pwdata;
				8'h34: comp_r <= apb_pwdata;
				8'h38: state_r <= apb_pwdata;
				default: ; // nothing to do
			endcase
		end
	end

	reg [31:0] pwm_cnt;
	always @(posedge apb_pclk) 
	begin
		if (~apb_prstn) 
		begin
			pwm_cnt <= 'b0;
		end 
		else if (pwm_cnt >= div_freq - 1)
		begin
			pwm_cnt <= 'b0;
		end 
		else if (start) 
		begin
			pwm_cnt <= pwm_cnt + 1'b1;
		end
	end

	reg pwm;
	always @(posedge apb_pclk) 
	begin
		if (~apb_prstn) 
		begin
			pwm <= 1'b0;
		end 
		else if (~start || div_freq == 'b0 || comp == 'b0) 
		begin
			pwm <= 1'b0;
		end 
		else if (pwm_cnt < comp || comp >= div_freq) 
		begin
			pwm <= 1'b1;
		end 
		else 
		begin
			pwm <= 1'b0;
		end
	end
	assign PWM01 = pwm;

	reg  [31:0]     rdata;
	always @(*) begin
		if(~apb_psel | apb_pwrite) 
			rdata = 32'b0;
		else if (re)
		begin
			case (apb_paddr[7:0])
				8'h30: rdata = div_freq;
				8'h34: rdata = comp;
				8'h38: rdata = state;
				8'h3c: rdata = pwm_cnt;
				default: rdata = 32'b0;
			endcase
		end
	end

	assign apb_prdata = rdata;
endmodule // apb_pwm


