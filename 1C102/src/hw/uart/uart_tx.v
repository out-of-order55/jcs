module UART_TX (
	input wire clk,
	input wire rstn,
	input wire tx_start,        
	input wire b_tick,          // baud rate tick
	input wire [7:0] d_in,      // input data
	output reg tx_done,         // transfer finished
	output wire tx,             // output data to RS-232

	input parity_check
);

	// STATE DEFINES  
	localparam [1:0] idle_st = 2'b00;
	localparam [1:0] start_st = 2'b01;
	localparam [1:0] data_st = 2'b11;
	localparam [1:0] stop_st = 2'b10;
	
	// Internal Signals  
	reg [1:0] current_state;
	reg [1:0] next_state;
	reg [3:0] b_reg;          // baud tick counter
	reg [3:0] b_next;
	reg [2:0] count_reg;      // data bit counter
	reg [2:0] count_next;
	reg [7:0] data_reg;       // data register
	reg [7:0] data_next;
	reg tx_reg;               // output data reg
	reg tx_next;
	
	// State Machine  
	always@(posedge clk, negedge rstn)
	begin
		if(!rstn)
		begin
			current_state <= idle_st;
			b_reg <= 0;
			count_reg <= 0;
			data_reg <= 0;
			tx_reg <= 1'b1;
		end
		else
		begin
			current_state <= next_state;
			b_reg <= b_next;
			count_reg <= count_next;
			data_reg <= data_next;
			tx_reg <= tx_next;
		end
	end

	// ================================================================ parity check below
	assign eor_value = d_in[6] ^ d_in[5] ^ d_in[4] ^ d_in[3] ^ d_in[2] ^ d_in[1] ^ d_in[0];
	// ================================================================ parity check above

	// Next State Logic
	always @(*)
	begin
		next_state = current_state;
		tx_done = 1'b0;
		b_next = b_reg;
		count_next = count_reg;
		data_next = data_reg;
		tx_next = tx_reg;

		case(current_state)
		idle_st:
		begin
			tx_next = 1'b1;
			if(tx_start)
			begin
				next_state = start_st;
				b_next = 0;
				// data_next = d_in;
				// ================================================================ parity check below
				if(parity_check == 0)
				begin
					data_next = d_in;
				end
				else
				begin
					data_next[6:0] = d_in[6:0];
					if(eor_value) 
					begin
						data_next[7] = 0;
					end
					else 
					begin
						data_next[7] = 1;
					end
				end
				// ================================================================ parity check above
			end
		end
		
		start_st: // send start bit
		begin
			tx_next = 1'b0;
			if(b_tick)
				if(b_reg == 3)
				begin
					next_state = data_st;
					b_next = 0;
					count_next = 0;
				end
			else
				b_next = b_reg + 1;
		end
		
		data_st: // send data serially
		begin
			tx_next = data_reg[0];
			if(b_tick)
				if(b_reg == 3)
				begin
					b_next = 0;
					data_next = data_reg >> 1;
					if(count_reg == 7)// 8 data bits
						next_state = stop_st;
					else
						count_next = count_reg + 1;
				end
				else
					b_next = b_reg + 1;
		end
		
		stop_st: // send stop bit
		begin
			tx_next = 1'b1;
			if(b_tick)
				if(b_reg == 3)// one stop bit
				begin
					next_state = idle_st;
					tx_done = 1'b1;
				end
			else
				b_next = b_reg + 1;
		end
		endcase
	end
	
	assign tx = tx_reg;

endmodule


