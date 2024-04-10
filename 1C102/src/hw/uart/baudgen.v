module BAUDGEN (
	input wire clk,
	input wire rstn,
	output wire baudtick,

	input [1:0] baudtick_ctrl// ================================================================
);

	reg [21:0] count_reg;
	wire [21:0] count_next;

	// Counter
	always @(posedge clk, negedge rstn)
	begin
		if(!rstn)
			count_reg <= 0;
		else
			count_reg <= count_next;
	end

	// ================================================================
	reg [7:0] counting_targets;
	always @(*)
	begin
		case(baudtick_ctrl)
			2'b00:
			begin
				counting_targets = 207;// 208.333 9600
			end
			2'b01:
			begin
				counting_targets = 103;// 104.166 19200
			end
			2'b10:
			begin
				counting_targets = 51;// 52.083 38400
			end
			2'b11:
			begin
				counting_targets = 16;// 17.361 115200
			end
		endcase
	end
	// ================================================================

	// Baudrate = 9600 = 8Mhz / (208.333 * 4)
	// Baudrate = 19200 = 8Mhz / (104.166 * 4)
	// Baudrate = 38400 = 8Mhz / (52.083 * 4)
	// Baudrate = 115200 = 8Mhz / (17.361 * 4)
	assign count_next = ((count_reg == counting_targets) ? 0 : count_reg + 1'b1);
	assign baudtick = ((count_reg == counting_targets) ? 1'b1 : 1'b0);
	
endmodule


