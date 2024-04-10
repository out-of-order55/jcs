module UART_TOP (
	input wire         apb_pclk,
	input wire         apb_prstn,
	input wire         apb_psel,
	input wire  [31:0] apb_paddr,
	
	input wire         apb_pwrite,
	input wire         apb_penable,
	input wire  [31:0] apb_pwdata,
	output wire [31:0] apb_prdata,
	
	input wire         RsRx,
	output wire        RsTx,

	output wire 	   uart_irq
);
	
	// Data I/O between APB and FIFO
	wire [7:0] uart_wdata;  
	wire [7:0] uart_rdata;
	
	// Signals from TX/RX to FIFOs
	wire uart_wr;
	wire uart_rd;
	
	// wires between FIFO and TX/RX
	wire [7:0] tx_data;
	wire [7:0] rx_data;
	wire [7:0] status;
	
	// FIFO Status
	wire tx_full;
	wire tx_empty;
	wire rx_full;
	wire rx_empty;
	
	// UART status ticks
	wire tx_done;
	wire rx_done;
	
	// baud rate signal
	wire b_tick;
	
	reg [31:0] last_paddr;
	reg last_pwrite;
	reg last_psel;
	
	// Set Registers for APB Address State
	always@(posedge apb_pclk)
	begin
		begin
			last_psel <= apb_psel;
			last_paddr <= apb_paddr;
			last_pwrite <= apb_pwrite;
		end
	end
	
	// UART write select
	assign uart_wr = last_pwrite & last_psel & (last_paddr[7:0] == 8'h00);
	// ================================================================
	assign uart_ctrl_reg_wr = last_pwrite & last_psel & (last_paddr[7:0] == 8'h04);
	// ================================================================
	
	// Only write last 8 bits of Data
	assign uart_wdata = apb_pwdata[7:0];
	
	// UART read select
	assign uart_rd = ~last_pwrite & last_psel & (last_paddr[7:0] == 8'h00);
	
	assign apb_prdata = (last_paddr[7:0] == 8'h00) ? {24'h0000_00, uart_rdata}:
					(last_paddr[7:0] == 8'h04) ? {24'h0000_00, status}:
												 {32'h0000_00};

	assign status = {6'b000000, tx_full, rx_empty};
	
	assign uart_irq = ~rx_empty;
	
	// ================================================================
	reg [2:0] uart_ctrl_reg;
	always@(posedge apb_pclk or negedge apb_prstn)
	begin
		if(~apb_prstn)
		begin
			uart_ctrl_reg <= 0;
		end
		else if(uart_ctrl_reg_wr)
		begin
			uart_ctrl_reg <= apb_pwdata[2:0];
		end
		else
		begin
			uart_ctrl_reg <= uart_ctrl_reg;
		end
	end
	// ================================================================

	// generate a fixed baud rate 19200bps
	BAUDGEN uBAUDGEN (
		.clk(apb_pclk),
		.rstn(apb_prstn),
		.baudtick(b_tick),
		.baudtick_ctrl(uart_ctrl_reg[1:0])// ================================================================
	);
	
	// Transmitter FIFO
	UART_TFIFO  
	#(.DWIDTH(8), .AWIDTH(4))
	uFIFO_TX (
		.clk(apb_pclk),
		.rstn(apb_prstn),
		.rd(tx_done),
		.wr(uart_wr),
		.w_data(uart_wdata[7:0]),
		.empty(tx_empty),
		.full(tx_full),
		.r_data(tx_data[7:0])
	);
	
	// Receiver FIFO
	UART_RFIFO 
	#(.DWIDTH(8), .AWIDTH(4))
	uFIFO_RX (
		.clk(apb_pclk),
		.rstn(apb_prstn),
		.rd(uart_rd),
		.wr(rx_done),
		.w_data(rx_data[7:0]),
		.empty(rx_empty),
		.full(rx_full),
		.r_data(uart_rdata[7:0])
	);
	
	// UART receiver
	UART_RX uUART_RX (
		.clk(apb_pclk),
		.rstn(apb_prstn),
		.b_tick(b_tick),
		.rx(RsRx),
		.rx_done(rx_done),
		.dout(rx_data[7:0]),
		.parity_check(uart_ctrl_reg[2])// ================================================================
	);
	
	// UART transmitter
	UART_TX uUART_TX (
		.clk(apb_pclk),
		.rstn(apb_prstn),
		.tx_start(!tx_empty),
		.b_tick(b_tick),
		.d_in(tx_data[7:0]),
		.tx_done(tx_done),
		.tx(RsTx),
		.parity_check(uart_ctrl_reg[2])// ================================================================
	);
	
endmodule
