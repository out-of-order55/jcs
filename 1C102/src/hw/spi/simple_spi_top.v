// Currently only MASTER mode is supported

module simple_spi_top (
	// 8bit WISHBONE bus slave interface
	input  wire       clk_i,         // clock
	input  wire       rst_i,         // reset (asynchronous active low)
	input  wire       cyc_i,         // cycle 
	input  wire       stb_i,         // strobe 
	input  wire [3:0] adr_i,         // address
	input  wire       we_i,          // write enable 
	input  wire [7:0] dat_i,         // data input
	output reg  [7:0] dat_o,         // data output
	output reg        ack_o,         // normal bus termination

	output reg        inta_o,        // interrupt output

	// SPI port
	output reg        sck_o,         // serial clock output 
	output wire       mosi_o,        // MasterOut SlaveIN 
	input  wire       miso_i,        // MasterIn SlaveOut

	// added for SFC
	output reg  [7:0] param,
	output reg  [7:0] param2,
	output reg  [7:0] softcs,
	output reg        busy
);

	//
	// Module body
	//
	reg  [7:0] spcr;       // Serial Peripheral Control Register ('HC11 naming)
	wire [7:0] spsr;       // Serial Peripheral Status register ('HC11 naming)
	reg  [7:0] sper;       // Serial Peripheral Extension register
	reg  [7:0] treg, rreg; // Transmit/Receive register

	// fifo signals
	wire [7:0] rfdout;
	reg        wfre, rfwe;
	wire       rfre, rffull, rfempty;
	wire [7:0] wfdout;
	wire       wfwe, wffull, wfempty;

	// misc signals
	wire      tirq;     // transfer interrupt (selected number of transfers done)
	wire      wfov;     // write fifo overrun (writing while fifo full)
	reg [1:0] state;    // statemachine state
	reg [2:0] bcnt;

	//
	// Wishbone interface
	wire wb_acc = cyc_i & stb_i;       // WISHBONE access 
	wire wb_wr  = wb_acc & we_i;       // WISHBONE write access 
	// wb_acc?
	

	// dat_i
	always @(posedge clk_i)
		if (~rst_i)
		begin
			spcr <= 8'h12;  // set master bit, clk div 16
			sper <= 8'h00;
			`ifdef FAST_SIMU
			param<= 8'h3;  // memory_en
			param2<=8'h07;  // CSH=3(max)
			`else
			param<= 8'h3;   // memory_en    // modified for LS1D, since clk is only 8MHz, most spi flash support burst
			param2<=8'h03;  // CSH=3(max)
			`endif
			softcs<=8'hf0;  // software cs, taken cared by SFC
		end
		else if (wb_wr)
		begin
			if (adr_i == 4'b00)
				spcr <= dat_i | 8'h10; // always set master bit
			if (adr_i == 4'b11)
				sper <= dat_i;
			if (adr_i == 4'b0100)
				param <= dat_i;
			if (adr_i == 4'b0101)
				softcs<= dat_i;
			if (adr_i == 4'b0110)
				param2 <= dat_i;// not use
		end

	// write fifo
	assign wfwe = wb_acc & (adr_i == 4'b10) & ack_o & we_i;
	assign wfov = wfwe & wffull;
	// when a write data register operation is required and the write register is full, the write register overflow flag bit 'wfov' is 1

	// dat_o
	always @(*) //posedge clk_i  -- by smh, make it faster...
		case(adr_i) // synopsys full_case parallel_case
		4'b0000: dat_o = spcr;
		4'b0001: dat_o = spsr;
		4'b0010: dat_o = rfdout;
		4'b0011: dat_o = sper;
		4'b0100: dat_o = param;
		4'b0101: dat_o = softcs;
		4'b0110: dat_o = param2;
		default  dat_o = 8'h0;
		endcase

	// read fifo
	assign rfre = wb_acc & (adr_i == 2'b10) & ack_o & ~we_i;

	// ack_o
	always @(posedge clk_i)
		ack_o <= 1'b1;
	/* -----\/----- EXCLUDED -----\/----- by smh, not wishbone anymore
		if (~rst_i)
			ack_o <= 1'b0;
		else
			ack_o <= wb_acc & !ack_o;
	-----/\----- EXCLUDED -----/\----- */
	
	// why 'ack_o' is always 1?

	// decode Serial Peripheral Control Register
	wire       spie = spcr[7];   // Interrupt enable bit
	wire       spe  = spcr[6];   // System Enable bit 
	wire       dwom = spcr[5];   // Port D Wired-OR Mode Bit
	wire       mstr = spcr[4];   // Master Mode Select Bit 
	wire       cpol = spcr[3];   // Clock Polarity Bit 
	wire       cpha = spcr[2];   // Clock Phase Bit
	wire [1:0] spr  = spcr[1:0]; // Clock Rate Select Bits

	// decode Serial Peripheral Extension Register
	wire [1:0] icnt = sper[7:6]; // interrupt on transfer count
	wire [1:0] spre = sper[1:0]; // extended clock rate select
	wire    smh_spi = sper[2]; // select spi engine rewritten by smh  
	// smh_spi = 0:ampling and sending timing simultaneously, smh_spi = 1:sampling and sending timing are staggered by half a cycle

	wire [3:0] espr = {spre, spr};

	// generate status register
	wire wr_spsr = wb_wr & (adr_i == 2'b01);

	reg spif;
	always @(posedge clk_i)
		if (~spe)
			spif <= 1'b0;
		else
			spif <= (tirq | spif) & ~(wr_spsr & dat_i[7]);// the function of '~(wr_spsr & dat_i[7])' is to reset to 0

	reg wcol;
	always @(posedge clk_i)
		if (~spe)
			wcol <= 1'b0;
		else
			wcol <= (wfov | wcol) & ~(wr_spsr & dat_i[6]);// the function of '~(wr_spsr & dat_i[6])' is to reset to 0

	assign spsr[7]   = spif;
	assign spsr[6]   = wcol;
	assign spsr[5]   = 1'b0;
	assign spsr[4]   = busy;
	assign spsr[3]   = wffull;
	assign spsr[2]   = wfempty;
	assign spsr[1]   = rffull;
	assign spsr[0]   = rfempty;
	

	// generate IRQ output (inta_o)
	always @(posedge clk_i)
		inta_o <= spif & spie;

	//
	// hookup read/write buffer fifo
	spi_fifo4 #(8)
	rfifo(
			.clk   ( clk_i   ),
			.rst   ( rst_i   ),
			.clr   ( ~spe    ),
			.din   ( treg    ),
			.we    ( rfwe    ),
			.dout  ( rfdout  ),
			.re    ( rfre    ),
			.full  ( rffull  ),
			.empty ( rfempty )
	),
	wfifo(
			.clk   ( clk_i   ),
			.rst   ( rst_i   ),
			.clr   ( ~spe    ),
			.din   ( dat_i   ),
			.we    ( wfwe    ),
			.dout  ( wfdout  ),
			.re    ( wfre    ),
			.full  ( wffull  ),
			.empty ( wfempty )
	);

	//
	// generate clk divider
	reg [11:0] clkcnt;// if espr = 0, clkcnt is always 0?
	always @(posedge clk_i)
		if(spe & (|clkcnt & |state))
			clkcnt <= clkcnt - 11'h1;
		else
		case (espr) // synopsys full_case parallel_case
			4'b0000: clkcnt <= 12'h0;   // 2   -- original M68HC11 coding
			4'b0001: clkcnt <= 12'h1;   // 4   -- original M68HC11 coding
			4'b0010: clkcnt <= 12'h7;   // 16  -- original M68HC11 coding
			4'b0011: clkcnt <= 12'hf;   // 32  -- original M68HC11 coding
			4'b0100: clkcnt <= 12'h3;   // 8
			4'b0101: clkcnt <= 12'h1f;  // 64
			4'b0110: clkcnt <= 12'h3f;  // 128
			4'b0111: clkcnt <= 12'h7f;  // 256
			4'b1000: clkcnt <= 12'hff;  // 512
			4'b1001: clkcnt <= 12'h1ff; // 1024
			4'b1010: clkcnt <= 12'h3ff; // 2048
			4'b1011: clkcnt <= 12'h7ff; // 4096
			default:;
		endcase

	// generate clock enable signal
	wire ena = ~|clkcnt;

	// transfer statemachine
	reg sample;
	always @ (posedge clk_i)
		if (~spe)
		begin
			state <= 2'b00; // idle
			bcnt  <= 3'h0;
			treg  <= 8'h00;
			wfre  <= 1'b0;
			rfwe  <= 1'b0;
			sck_o <= 1'b0;
		end
		else if (smh_spi)
		begin
			wfre <= 1'b0;
			rfwe <= 1'b0;

			case (state) // synopsys full_case parallel_case
			2'b00: // idle state
				begin
					bcnt  <= 3'h7;   // set transfer counter
					treg  <= wfdout; // load transfer register 
					sck_o <= cpol;   // set sck 

					if (~wfempty) begin
						wfre  <= 1'b1;
						state <= 2'b01;
					end
				end

			2'b01: // header, prepare the first half sck, for CPHA=0
				if (ena) begin
					sck_o   <= ~sck_o; // leaving, to stat 10
					state   <= 2'b10;
					if (cpha==0) sample <= miso_i;
					// sending treg[7] in this state, so I think sampling and sending are synchronized
				end

			2'b10: // S1
				if (ena) begin
					sck_o <= ~sck_o;
					state <= 2'b11;
					if (cpha==0) begin
						treg   <= {treg[6:0], sample};
						// if cpha = 0, treg[7] has been already been sampled, so prepare the next data to be send
					end else begin
						sample <= miso_i;
					end
				end

			2'b11: // S2
				if (ena) begin
					bcnt <= bcnt -3'h1;
					if (cpha==0) begin
						sample <= miso_i;
					end else begin
						treg   <= {treg[6:0], sample};
					end

					if (~|bcnt) begin
						state <= 2'b00;
						sck_o <= cpol;
						rfwe  <= 1'b1;
					end else begin
						state <= 2'b10;
						sck_o <= ~sck_o;
					end
				end

			endcase
		end
		else
		begin
			wfre <= 1'b0;
			rfwe <= 1'b0;

			case (state) //synopsys full_case parallel_case
			2'b00: // idle state
			begin
				bcnt  <= 3'h7;   // set transfer counter
				treg  <= wfdout; // load transfer register 
				sck_o <= cpol;   // set sck

				if (~wfempty) begin
					wfre  <= 1'b1;
					state <= 2'b01;
					if (cpha) sck_o <= ~sck_o;
				end
			end

			2'b01: // clock-phase2, next data
			if (ena) begin
				sck_o <= ~sck_o;
				state <= 2'b11;
			end

			2'b11: // clock phase1
			if (ena) begin
				treg <= {treg[6:0], miso_i};
				bcnt <= bcnt -3'h1;

				if (~|bcnt) begin
					state <= 2'b00;
					sck_o <= cpol;
					rfwe  <= 1'b1;
				end
				else begin
					state <= 2'b01;
					sck_o <= ~sck_o;
				end
			end

			2'b10: state <= 2'b00;
			default: state <=2'b00;
			endcase
		end

	assign mosi_o = treg[7];

	// count number of transfers (for interrupt generation)
	reg [1:0] tcnt;// transfer count
	always @(posedge clk_i)
		if (~spe)
			tcnt <= icnt;
		else if (rfwe) begin// rfwe gets asserted when all bits have been transfered
			if (|tcnt)
				tcnt <= tcnt - 2'h1;
			else
				tcnt <= icnt;
		end

	assign tirq = ~|tcnt & rfwe;

	always @(posedge clk_i)
		busy <= ~wfempty | (|state);

endmodule


