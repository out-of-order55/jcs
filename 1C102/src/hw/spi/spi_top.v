`include "../config.v"

module SPI_TOP (
	input  wire       apb_pclk, 
	input  wire       apb_prstn,
	input  wire       apb_psel,
	input  wire [3:0] apb_paddr,
	input  wire       apb_pwrite,
	input  wire       apb_penable,
	input  wire [7:0] apb_pwdata,
	output reg  [7:0] apb_prdata,

	output wire 	  SPI_CLK,  
	input  wire 	  SPI_MISO, 
	output wire 	  SPI_MOSI, 
	output wire 	  SPI_CSN1, 
	output wire 	  SPI_CSN2, 
	output wire 	  SPI_CSN3,
	
	output reg        spi_int        // interrupt output
);

    reg        sck_e ;
    wire       miso_i;
    wire       mosi_o;
    wire [3:0] csn_e ;

	assign SPI_CSN1_e = csn_e[1];
	assign SPI_CSN2_e = csn_e[2];
	assign SPI_CSN3_e = csn_e[3];

	assign SPI_CLK  = sck_e 	;
	assign miso_i   = SPI_MISO  ;
	assign SPI_MOSI = mosi_o    ;
	assign SPI_CSN1 =~SPI_CSN1_e;
	assign SPI_CSN2 =~SPI_CSN2_e;
	assign SPI_CSN3 =~SPI_CSN3_e;

	//
	// Module body
	//
	reg  [7:0] spcr;       // Serial Peripheral Control Register
	wire [7:0] spsr;       // Serial Peripheral Status register 
	reg  [7:0] sper;       // Serial Peripheral Extension register
	reg  [7:0] treg, rreg; // Transmit/Receive register
	reg  [7:0] softcs;
	wire [3:0] csn_en;
	reg busy;
	reg  [7:0] data_i;

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

	reg psel_r, pwrite_r, penable_r;
	reg [7:0] paddr_r, pwdata_r;
	always @(posedge apb_pclk) begin
		if (~apb_prstn)
		begin
			psel_r    <= 1'b0;
			pwrite_r  <= 1'b0;
			penable_r <= 1'b0;  
			paddr_r   <= 8'b0;
			pwdata_r  <= 8'b0;
		end
		else
		begin
			psel_r    <= apb_psel;
			pwrite_r  <= apb_pwrite;
			penable_r <= apb_penable;  
			paddr_r   <= apb_paddr;
			pwdata_r  <= apb_pwdata;
		end
	end

	wire we = psel_r & pwrite_r & penable_r;
	wire re = psel_r &~pwrite_r & penable_r;

	always @(posedge apb_pclk)
		if (~apb_prstn)
		begin
			spcr   <= 8'h10;  // set master bit, clk div 2
			sper   <= 8'h00;
			softcs <= 8'hf0;  // software cs, taken cared by SFC
			data_i <= 8'h00;
		end
		else if (we)
		begin
			if (paddr_r == 4'b00)
				spcr <= pwdata_r | 8'h10; // always set master bit
			if (paddr_r == 4'b11)
				sper <= pwdata_r;
			if (paddr_r == 4'b0101)
				softcs<= pwdata_r;	
		end

	assign     csn_en[3:0] = softcs[3:0];// 
	assign     csn_e [3:0] = ~softcs[7:4] & csn_en;//

	// write fifo
	// when a write data register operation is required and the write register is full, the write register overflow flag bit 'wfov' is 1
	assign wfwe = we & (paddr_r == 4'b10);
	assign wfov = we & wffull;
	
	// apb_prdata
	always @(*) //posedge apb_pclk  -- by smh, make it faster...
	
	// in this block, it is false to using 're' for reading.
		case(paddr_r) // synopsys full_case parallel_case
			4'b0000: apb_prdata = spcr;
			4'b0001: apb_prdata = spsr;
			4'b0010: apb_prdata = rfdout;
			4'b0011: apb_prdata = sper;
			4'b0101: apb_prdata = softcs;
			default  apb_prdata = 8'h0;
		endcase

	// read fifo
	assign rfre = re & (paddr_r == 2'b10);

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
	wire wr_spsr = we & (paddr_r == 2'b01);

	reg spif;
	always @(posedge apb_pclk)
		if (~spe)
			spif <= 1'b0;
		else
			spif <= (tirq | spif) & ~(wr_spsr & pwdata_r[7]);// the function of '~(wr_spsr & pwdata_r[7])' is to reset to 0

	reg wcol;
	always @(posedge apb_pclk)
		if (~spe)
			wcol <= 1'b0;
		else
			wcol <= (wfov | wcol) & ~(wr_spsr & pwdata_r[6]);// the function of '~(wr_spsr & pwdata_r[6])' is to reset to 0

	assign spsr[7]   = spif;
	assign spsr[6]   = wcol;
	assign spsr[5]   = 1'b0;
	assign spsr[4]   = busy;
	assign spsr[3]   = wffull;
	assign spsr[2]   = wfempty;
	assign spsr[1]   = rffull;
	assign spsr[0]   = rfempty;
	
	// generate IRQ output (spi_int)
	always @(posedge apb_pclk)
		spi_int <= spif & spie;

	//
	// hookup read/write buffer fifo
	spi_fifo4 #(8)
	rfifo (
			.clk   ( apb_pclk    ),
			.rst   ( apb_prstn   ),
			.clr   ( ~spe        ),
			.din   ( treg        ),
			.we    ( rfwe        ),
			.dout  ( rfdout      ),
			.re    ( rfre        ),
			.full  ( rffull      ),
			.empty ( rfempty     )
	),
	wfifo (
			.clk   ( apb_pclk    ),
			.rst   ( apb_prstn   ),
			.clr   ( ~spe        ),
			.din   ( pwdata_r    ),
			.we    ( wfwe        ),
			.dout  ( wfdout      ),
			.re    ( wfre        ),
			.full  ( wffull      ),
			.empty ( wfempty     )
	);		

	//
	// generate clk divider
	reg [11:0] clkcnt;// if espr = 0, clkcnt is always 0? right.
	always @(posedge apb_pclk)
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
	always @(posedge apb_pclk)
		if (~spe)
		begin
			state <= 2'b00; // idle
			bcnt  <= 3'h0;
			treg  <= 8'h00;
			wfre  <= 1'b0;
			rfwe  <= 1'b0;
			sck_e <= 1'b0;
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
					sck_e <= cpol;   // set sck 

					if (~wfempty) begin
						wfre  <= 1'b1;
						state <= 2'b01;
					end
				end

			2'b01: // header, prepare the first half sck, for CPHA=0
				if (ena) begin
					sck_e   <= ~sck_e; // leaving, to stat 10
					state   <= 2'b10;
					if (cpha==0) sample <= miso_i;
					// if cpha = 0, 'miso_i' is sampled to 'sample' in this state. and treg[7]is sent in this state. but what we 
					// are comparing is 'treg[0]' and 'treg[7]', so the two are staggered by half a cycle
				end

			2'b10: // S1
				if (ena) begin
					sck_e <= ~sck_e;
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
						sck_e <= cpol;
						rfwe  <= 1'b1;
					end else begin
						state <= 2'b10;
						sck_e <= ~sck_e;
					end
				end

			endcase
		end
		else begin
			wfre <= 1'b0;
			rfwe <= 1'b0;

			case (state) //synopsys full_case parallel_case
			2'b00: // idle state
			begin
				bcnt  <= 3'h7;   // set transfer counter
				treg  <= wfdout; // load transfer register 
				sck_e <= cpol;   // set sck

				if (~wfempty) begin
					wfre  <= 1'b1;
					state <= 2'b01;
					if (cpha) sck_e <= ~sck_e;
				end
			end

			2'b01: // clock-phase2, next data
			if (ena) begin
				sck_e <= ~sck_e;
				state <= 2'b11;
			end

			2'b10: state <= 2'b00;

			2'b11: // clock phase1
			if (ena) begin
				treg <= {treg[6:0], miso_i};
				bcnt <= bcnt -3'h1;

				if (~|bcnt) begin
					state <= 2'b00;
					sck_e <= cpol;
					rfwe  <= 1'b1;
				end
				else begin
					state <= 2'b01;
					sck_e <= ~sck_e;
				end
			end

			default: state <=2'b00;
			endcase
		end

	assign mosi_o = treg[7];


	// count number of transfers (for interrupt generation)
	reg [1:0] tcnt;// transfer count
	always @(posedge apb_pclk)
		if (~spe)
			tcnt <= icnt;
		else if (rfwe) begin// rfwe gets asserted when all bits have been transfered
			if (|tcnt)
				tcnt <= tcnt - 2'h1;
			else
				tcnt <= icnt;
		end

	assign tirq = ~|tcnt & rfwe;

	always @(posedge apb_pclk)
		busy <= ~wfempty | (|state);

endmodule


