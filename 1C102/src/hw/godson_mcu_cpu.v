`include "config.v"

module godson_mcu_cpu (
    input         clock,
    input         reset,

    output        apb0_psel,
    output [31:0] apb0_paddr,
    output        apb0_pwrite,
	output        apb0_penable,
    output [31:0] apb0_pwdata,
    input  [31:0] apb0_prdata,
    input         apb0_ack,

    output        apb1_psel,
    output [31:0] apb1_paddr,
    output        apb1_pwrite,
	output        apb1_penable,
    output [31:0] apb1_pwdata,
    input  [31:0] apb1_prdata,
    input         apb1_ack,

    output        apb2_psel,
    output [31:0] apb2_paddr,
    output        apb2_pwrite,
	output        apb2_penable,
    output [31:0] apb2_pwdata,
    input  [31:0] apb2_prdata,
    input         apb2_ack,
    

    output        apb3_psel,
    output [31:0] apb3_paddr,
    output        apb3_pwrite,
	output        apb3_penable,
    output [31:0] apb3_pwdata,
    input  [31:0] apb3_prdata,
    input         apb3_ack,

    output        apb4_psel,
    output [31:0] apb4_paddr,
    output        apb4_pwrite,
	output        apb4_penable,
    output [31:0] apb4_pwdata,
    input  [31:0] apb4_prdata,
    input         apb4_ack,
    

    output        apb5_psel,
    output [31:0] apb5_paddr,
    output        apb5_pwrite,
	output        apb5_penable,
    output [31:0] apb5_pwdata,
    input  [31:0] apb5_prdata,
    input         apb5_ack,

    output        apb6_psel,
    output [31:0] apb6_paddr,
    output        apb6_pwrite,
	output        apb6_penable,
    output [31:0] apb6_pwdata,
    input  [31:0] apb6_prdata,
    input         apb6_ack,


    output        apb7_psel,
    output [31:0] apb7_paddr,
    output        apb7_pwrite,
	output        apb7_penable,
    output [31:0] apb7_pwdata,
    input  [31:0] apb7_prdata,
    input         apb7_ack,

    output        apb8_psel,
    output [31:0] apb8_paddr,
    output        apb8_pwrite,
	output        apb8_penable,
    output [31:0] apb8_pwdata,
    input  [31:0] apb8_prdata,
    input         apb8_ack,
    
	input [5:0]   interrupt,

    input         ljtag_trst_i,
    input         ljtag_tms_i,
    output        ljtag_tdo_o,
    input         ljtag_tdi_i,
    input         ljtag_tck_i,
	
	//AXI
	output [`LID         -1 :0] s1_awid,
	output [`Lawaddr     -1 :0] s1_awaddr,
	output [`Lawlen      -1 :0] s1_awlen,
	output [`Lawsize     -1 :0] s1_awsize,
	output [`Lawburst    -1 :0] s1_awburst,
	output [`Lawlock     -1 :0] s1_awlock,
	output [`Lawcache    -1 :0] s1_awcache,
	output [`Lawprot     -1 :0] s1_awprot,
	output                      s1_awvalid,
	input                       s1_awready,
	output [`LID         -1 :0] s1_wid,
	output [`Lwdata      -1 :0] s1_wdata,
	output [`Lwstrb      -1 :0] s1_wstrb,
	output                      s1_wlast,
	output                      s1_wvalid,
	input                       s1_wready,
	input  [`LID         -1 :0] s1_bid,
	input  [`Lbresp      -1 :0] s1_bresp,
	input                       s1_bvalid,
	output                      s1_bready,
	output [`LID         -1 :0] s1_arid,
	output [`Laraddr     -1 :0] s1_araddr,
	output [`Larlen      -1 :0] s1_arlen,
	output [`Larsize     -1 :0] s1_arsize,
	output [`Larburst    -1 :0] s1_arburst,
	output [`Larlock     -1 :0] s1_arlock,
	output [`Larcache    -1 :0] s1_arcache,
	output [`Larprot     -1 :0] s1_arprot,
	output                      s1_arvalid,
	input                       s1_arready,
	input  [`LID         -1 :0] s1_rid,
	input  [`Lrdata      -1 :0] s1_rdata,
	input  [`Lrresp      -1 :0] s1_rresp,
	input                       s1_rlast,
	input                       s1_rvalid,
	output                      s1_rready

);



	wire [`LID         -1 :0] cpu_awid;
	wire [`Lawaddr     -1 :0] cpu_awaddr;
	wire [`Lawlen      -1 :0] cpu_awlen;
	wire [`Lawsize     -1 :0] cpu_awsize;
	wire [`Lawburst    -1 :0] cpu_awburst;
	wire [`Lawlock     -1 :0] cpu_awlock;
	wire [`Lawcache    -1 :0] cpu_awcache;
	wire [`Lawprot     -1 :0] cpu_awprot;
	wire                      cpu_awvalid;
	wire                      cpu_awready;
	wire [`LID         -1 :0] cpu_wid;
	wire [`Lwdata      -1 :0] cpu_wdata;
	wire [`Lwstrb      -1 :0] cpu_wstrb;
	wire                      cpu_wlast;
	wire                      cpu_wvalid;
	wire                      cpu_wready;
	wire [`LID         -1 :0] cpu_bid;
	wire [`Lbresp      -1 :0] cpu_bresp;
	wire                      cpu_bvalid;
	wire                      cpu_bready;
	wire [`LID         -1 :0] cpu_arid;
	wire [`Laraddr     -1 :0] cpu_araddr;
	wire [`Larlen      -1 :0] cpu_arlen;
	wire [`Larsize     -1 :0] cpu_arsize;
	wire [`Larburst    -1 :0] cpu_arburst;
	wire [`Larlock     -1 :0] cpu_arlock;
	wire [`Larcache    -1 :0] cpu_arcache;
	wire [`Larprot     -1 :0] cpu_arprot;
	wire                      cpu_arvalid;
	wire                      cpu_arready;
	wire [`LID         -1 :0] cpu_rid;
	wire [`Lrdata      -1 :0] cpu_rdata;
	wire [`Lrresp      -1 :0] cpu_rresp;
	wire                      cpu_rlast;
	wire                      cpu_rvalid;
	wire                      cpu_rready;

	wire [`LID         -1 :0] apb_awid;
	wire [`Lawaddr     -1 :0] apb_awaddr;
	wire [`Lawlen      -1 :0] apb_awlen;
	wire [`Lawsize     -1 :0] apb_awsize;
	wire [`Lawburst    -1 :0] apb_awburst;
	wire [`Lawlock     -1 :0] apb_awlock;
	wire [`Lawcache    -1 :0] apb_awcache;
	wire [`Lawprot     -1 :0] apb_awprot;
	wire                      apb_awvalid;
	wire                      apb_awready;
	wire [`LID         -1 :0] apb_wid;
	wire [`Lwdata      -1 :0] apb_wdata;
	wire [`Lwstrb      -1 :0] apb_wstrb;
	wire                      apb_wlast;
	wire                      apb_wvalid;
	wire                      apb_wready;
	wire [`LID         -1 :0] apb_bid;
	wire [`Lbresp      -1 :0] apb_bresp;
	wire                      apb_bvalid;
	wire                      apb_bready;
	wire [`LID         -1 :0] apb_arid;
	wire [`Laraddr     -1 :0] apb_araddr;
	wire [`Larlen      -1 :0] apb_arlen;
	wire [`Larsize     -1 :0] apb_arsize;
	wire [`Larburst    -1 :0] apb_arburst;
	wire [`Larlock     -1 :0] apb_arlock;
	wire [`Larcache    -1 :0] apb_arcache;
	wire [`Larprot     -1 :0] apb_arprot;
	wire                      apb_arvalid;
	wire                      apb_arready;
	wire [`LID         -1 :0] apb_rid;
	wire [`Lrdata      -1 :0] apb_rdata;
	wire [`Lrresp      -1 :0] apb_rresp;
	wire                      apb_rlast;
	wire                      apb_rvalid;
	wire                      apb_rready;
	


	wire                      apb_ack;
	wire                      apb_rw;
	wire                      apb_psel;
	wire                      apb_enab;
	wire [`ADDR_APB-1:0]      apb_addr;
	wire [`DATA_APB-1:0]      apb_datai;
	wire [`DATA_APB-1:0]      apb_datao;



	wire                      inst_sram_en;
	wire [ 3:0]               inst_sram_strb;
	wire [31:0]               inst_sram_wdata;
	wire [31:0]               inst_sram_rdata;
	wire                      inst_sram_wr;
	wire                      inst_sram_fetch;
	wire [31:0]               inst_sram_addr;
	wire                      inst_sram_rrdy = 1'b1;
	wire                      inst_sram_ack  = 1'b1;
	wire                      inst_sram_resp = 1'b0;
	wire                      inst_ram_clk = clock;

	wire                      data_sram_en;
	wire [ 3:0]               data_sram_strb;
	wire [31:0]               data_sram_wdata;
	wire [31:0]               data_sram_rdata;
	wire                      data_sram_wr;
	wire                      data_sram_fetch;
	wire [31:0]               data_sram_addr;
	wire                      data_sram_ack = 1'b1;
	wire                      data_sram_rrdy = 1'b1;
	wire                      data_sram_resp = 1'b0;
	wire                      data_ram_clk = clock;

	Flash_128k A_flash
    (
		.CLKin            (inst_ram_clk          ),
		.DO               (inst_sram_rdata       ),
		.AD               (inst_sram_addr        ),
		.STRB             (inst_sram_strb        ),
		.DI               (inst_sram_wdata       ),
		.EN               (inst_sram_en          ),
		.R_WB             (inst_sram_wr          ),
		.reset            (reset				 ) 
    );
	
    Dram_8k A_dram
    (
		.CLKin            (data_ram_clk          ),
		.DO               (data_sram_rdata       ),
		.AD               (data_sram_addr        ),
		.STRB             (data_sram_strb        ),
		.DI               (data_sram_wdata       ),
		.EN               (data_sram_en          ),
		.R_WB             (data_sram_wr          ),
		.reset            (reset				 ) 
    );

	wire [31:0] fetch_pc;
	wire        sleeping_o;
	wire [31:0]   debug_pc;

   // la132
la132_top  A_la132
	(
		.boot_pc          (32'h1c000000        ),
		.clk              (clock           	   ),
		.clk_count        (clock           	   ),
		.hard_resetn      (reset               ),
		.soft_resetn      (reset               ),

		.sleeping         (sleeping_o          ),
		.cpu_fetch_pc     (fetch_pc            ),
		.wb_pc            (debug_pc            ),
		.mode_lisa        (1'b1                ), 
		.inst_xor         (32'b0               ),

		.nmi              (1'b0                ),
		.ext_int          (interrupt           ),

		.arid             (cpu_arid[3:0]       ),
		.araddr           (cpu_araddr          ),
		.arlen            (cpu_arlen           ),
		.arsize           (cpu_arsize          ),
		.arburst          (cpu_arburst         ),
		.arlock           (cpu_arlock          ),
		.arcache          (cpu_arcache         ),
		.arprot           (cpu_arprot          ),
		.arvalid          (cpu_arvalid         ),
		.arready          (cpu_arready         ),

		.rid              (cpu_rid[3:0]        ),
		.rdata            (cpu_rdata           ),
		.rresp            (cpu_rresp           ),
		.rlast            (cpu_rlast           ),
		.rvalid           (cpu_rvalid          ),
		.rready           (cpu_rready          ),

		.awid             (cpu_awid[3:0]       ),
		.awaddr           (cpu_awaddr          ),
		.awlen            (cpu_awlen           ),
		.awsize           (cpu_awsize          ),
		.awburst          (cpu_awburst         ),
		.awlock           (cpu_awlock          ),
		.awcache          (cpu_awcache         ),
		.awprot           (cpu_awprot          ),
		.awvalid          (cpu_awvalid         ),
		.awready          (cpu_awready         ),

		.wid              (cpu_wid[3:0]        ),
		.wdata            (cpu_wdata           ),
		.wstrb            (cpu_wstrb           ),
		.wlast            (cpu_wlast           ),
		.wvalid           (cpu_wvalid          ),
		.wready           (cpu_wready          ),

		.bid              (cpu_bid[3:0]        ),
		.bresp            (cpu_bresp           ),
		.bvalid           (cpu_bvalid          ),
		.bready           (cpu_bready          ),

		.inst_sram_en     (inst_sram_en        ),
		.inst_sram_wr     (inst_sram_wr        ),
		.inst_sram_fetch  (inst_sram_fetch     ),
		.inst_sram_strb   (inst_sram_strb      ),
		.inst_sram_addr   (inst_sram_addr      ),
		.inst_sram_wdata  (inst_sram_wdata     ),
		.inst_sram_rdata  (inst_sram_rdata     ),
		.inst_sram_ack    (inst_sram_ack      ),
		.inst_sram_rrdy   (inst_sram_rrdy     ),
		.inst_sram_resp   (inst_sram_resp      ),

		.data_sram_en     (data_sram_en        ),
		.data_sram_wr     (data_sram_wr        ),
		.data_sram_fetch  (data_sram_fetch     ),
		.data_sram_strb   (data_sram_strb      ),
		.data_sram_addr   (data_sram_addr      ),
		.data_sram_wdata  (data_sram_wdata     ),
		.data_sram_rdata  (data_sram_rdata     ),
		.data_sram_ack    (data_sram_ack       ),
		.data_sram_rrdy   (data_sram_rrdy      ),
		.data_sram_resp   (data_sram_resp      ),

		.trstn            (ljtag_trst_i        ),
		.tck              (ljtag_tck_i         ),
		.tdi              (ljtag_tdi_i         ),
		.tms              (ljtag_tms_i         ),
		.tdo              (ljtag_tdo_o         ),
		.ljtag_prrst      (ljtag_prrst_src     ),
		.ljtag_lock       (1'b0                ),

		.prid_revision    (4'd0  			   ),
		.cpunum           (10'b0         	   ),

		.ibus0_valid      (1'b1                ),
		.ibus0_base       (32'h1c00_0000       ), // va: 1c00_0000 & bfc0_0000
		.ibus0_mask       (32'h1f00_0000       ), // flash 128K, + 4 special page
		.ibus1_valid      (1'b1                ),
		.ibus1_base       (32'h9f00_0000       ), // va: 9fR0_0000 & bf00_0000
		.ibus1_mask       (32'hdff0_0000       ),
		.ibus2_valid      (1'b0            	   ), // flash_en
		.ibus2_base       (32'h9fe6_0000       ), // va: 9fe6_0000 & bfe6_0000
		.ibus2_mask       (32'hdfff_ff00       ),
		.ibus3_valid      (1'b0                ), // compact_mem&flash_en),
		.ibus3_base       (32'h8000_3000       ), // for va: 8000_30xx & 0000_00xx -> pa: 0000_30xx & 4000_00xx
		.ibus3_mask       (32'h7fff_ff00       ),
		.dbus0_valid      (1'b1                ),
		.dbus0_base       (32'h8000_0000       ),
		.dbus0_mask       (32'hdfff_e000       ), // 8K byte, for va: 8000_0000 & a000_0000 -> pa: 0000_0000
		.dbus1_valid      (1'b1                ),
		.dbus1_base       (32'h0000_0000       ),
		.dbus1_mask       (32'hffff_e000       ), // 8K byte, for va: 0000_0000             -> pa: 0000_0000
		.dbus2_valid      (1'b0                ), // unused
		.dbus2_base       (32'h0000_0000       ),
		.dbus2_mask       (32'h0000_0000       ),
		.dbus3_valid      (1'b0                ), // unused
		.dbus3_base       (32'h0000_0000       ),
		.dbus3_mask       (32'h0000_0000       ),

		.test_mode        (1'b0                )
	);

	axi_slave_mux_cpu A_cpu_mux
    (
		.axi_s_aclk       (clock               ),
		.axi_s_aresetn    (reset           		),
		.axi_s_awid       (cpu_awid            ),
		.axi_s_awaddr     (cpu_awaddr          ),
		.axi_s_awlen      (cpu_awlen           ),
		.axi_s_awsize     (cpu_awsize          ),
		.axi_s_awburst    (cpu_awburst         ),
		.axi_s_awlock     (cpu_awlock          ),
		.axi_s_awcache    (cpu_awcache         ),
		.axi_s_awprot     (cpu_awprot          ),
		.axi_s_awvalid    (cpu_awvalid         ),
		.axi_s_awready    (cpu_awready         ),
		.axi_s_wready     (cpu_wready          ),
		.axi_s_wid        (cpu_wid             ),
		.axi_s_wdata      (cpu_wdata           ),
		.axi_s_wstrb      (cpu_wstrb           ),
		.axi_s_wlast      (cpu_wlast           ),
		.axi_s_wvalid     (cpu_wvalid          ),
		.axi_s_bid        (cpu_bid             ),
		.axi_s_bresp      (cpu_bresp           ),
		.axi_s_bvalid     (cpu_bvalid          ),
		.axi_s_bready     (cpu_bready          ),
		.axi_s_arid       (cpu_arid            ),
		.axi_s_araddr     (cpu_araddr          ),
		.axi_s_arlen      (cpu_arlen           ),
		.axi_s_arsize     (cpu_arsize          ),
		.axi_s_arburst    (cpu_arburst         ),
		.axi_s_arlock     (cpu_arlock          ),
		.axi_s_arcache    (cpu_arcache         ),
		.axi_s_arprot     (cpu_arprot          ),
		.axi_s_arvalid    (cpu_arvalid         ),
		.axi_s_arready    (cpu_arready         ),
		.axi_s_rready     (cpu_rready          ),
		.axi_s_rid        (cpu_rid             ),
		.axi_s_rdata      (cpu_rdata           ),
		.axi_s_rresp      (cpu_rresp           ),
		.axi_s_rlast      (cpu_rlast           ),
		.axi_s_rvalid     (cpu_rvalid          ),

		.s0_awid          (apb_awid            ),
		.s0_awaddr        (apb_awaddr          ),
		.s0_awlen         (apb_awlen           ),
		.s0_awsize        (apb_awsize          ),
		.s0_awburst       (apb_awburst         ),
		.s0_awlock        (apb_awlock          ),
		.s0_awcache       (apb_awcache         ),
		.s0_awprot        (apb_awprot          ),
		.s0_awvalid       (apb_awvalid         ),
		.s0_awready       (apb_awready         ),
		.s0_wid           (apb_wid             ),
		.s0_wdata         (apb_wdata           ),
		.s0_wstrb         (apb_wstrb           ),
		.s0_wlast         (apb_wlast           ),
		.s0_wvalid        (apb_wvalid          ),
		.s0_wready        (apb_wready          ),
		.s0_bid           (apb_bid             ),
		.s0_bresp         (apb_bresp           ),
		.s0_bvalid        (apb_bvalid          ),
		.s0_bready        (apb_bready          ),
		.s0_arid          (apb_arid            ),
		.s0_araddr        (apb_araddr          ),
		.s0_arlen         (apb_arlen           ),
		.s0_arsize        (apb_arsize          ),
		.s0_arburst       (apb_arburst         ),
		.s0_arlock        (apb_arlock          ),
		.s0_arcache       (apb_arcache         ),
		.s0_arprot        (apb_arprot          ),
		.s0_arvalid       (apb_arvalid         ),
		.s0_arready       (apb_arready         ),
		.s0_rid           (apb_rid             ),
		.s0_rdata         (apb_rdata           ),
		.s0_rresp         (apb_rresp           ),
		.s0_rlast         (apb_rlast           ),
		.s0_rvalid        (apb_rvalid          ),
		.s0_rready        (apb_rready          ),
		
		.s1_awid          (s1_awid             ),
		.s1_awaddr        (s1_awaddr           ),
		.s1_awlen         (s1_awlen            ),
		.s1_awsize        (s1_awsize           ),
		.s1_awburst       (s1_awburst          ),
		.s1_awlock        (s1_awlock           ),
		.s1_awcache       (s1_awcache          ),
		.s1_awprot        (s1_awprot           ),
		.s1_awvalid       (s1_awvalid          ),
		.s1_awready       (s1_awready          ),
		.s1_wid           (s1_wid              ),
		.s1_wdata         (s1_wdata            ),
		.s1_wstrb         (s1_wstrb            ),
		.s1_wlast         (s1_wlast            ),
		.s1_wvalid        (s1_wvalid           ),
		.s1_wready        (s1_wready           ),
		.s1_bid           (s1_bid              ),
		.s1_bresp         (s1_bresp            ),
		.s1_bvalid        (s1_bvalid           ),
		.s1_bready        (s1_bready           ),
		.s1_arid          (s1_arid             ),
		.s1_araddr        (s1_araddr           ),
		.s1_arlen         (s1_arlen            ),
		.s1_arsize        (s1_arsize           ),
		.s1_arburst       (s1_arburst          ),
		.s1_arlock        (s1_arlock           ),
		.s1_arcache       (s1_arcache          ),
		.s1_arprot        (s1_arprot           ),
		.s1_arvalid       (s1_arvalid          ),
		.s1_arready       (s1_arready          ),
		.s1_rid           (s1_rid              ),
		.s1_rdata         (s1_rdata            ),
		.s1_rresp         (s1_rresp            ),
		.s1_rlast         (s1_rlast            ),
		.s1_rvalid        (s1_rvalid           ),
		.s1_rready        (s1_rready           )
    );

   // axi2apb
	axi2apb_bridge A_axi2apb
    (
		.clk              (clock               ),
		.rst_n            (reset               ),
		.axi_s_awid       (apb_awid            ),//
		.axi_s_awaddr     (apb_awaddr          ),//
		.axi_s_awlen      (apb_awlen           ),//
		.axi_s_awsize     (apb_awsize          ),//
		.axi_s_awburst    (apb_awburst         ),//
		.axi_s_awlock     (apb_awlock          ),//
		.axi_s_awcache    (apb_awcache         ),//
		.axi_s_awprot     (apb_awprot          ),//
		.axi_s_awvalid    (apb_awvalid         ),//
		.axi_s_awready    (apb_awready         ),//
		.axi_s_wid        (apb_wid             ),//
		.axi_s_wdata      (apb_wdata           ),//
		.axi_s_wstrb      (apb_wstrb           ),//
		.axi_s_wlast      (apb_wlast           ),//
		.axi_s_wvalid     (apb_wvalid          ),//
		.axi_s_wready     (apb_wready          ),//
		.axi_s_bid        (apb_bid             ),//
		.axi_s_bresp      (apb_bresp           ),//
		.axi_s_bvalid     (apb_bvalid          ),//
		.axi_s_bready     (apb_bready          ),//
		.axi_s_arid       (apb_arid            ),//
		.axi_s_araddr     (apb_araddr          ),//
		.axi_s_arlen      (apb_arlen           ),//
		.axi_s_arsize     (apb_arsize          ),//
		.axi_s_arburst    (apb_arburst         ),//
		.axi_s_arlock     (apb_arlock          ),//
		.axi_s_arcache    (apb_arcache         ),//
		.axi_s_arprot     (apb_arprot          ),//
		.axi_s_arvalid    (apb_arvalid         ),//
		.axi_s_arready    (apb_arready         ),//
		.axi_s_rid        (apb_rid             ),//
		.axi_s_rdata      (apb_rdata           ),//
		.axi_s_rresp      (apb_rresp           ),//
		.axi_s_rlast      (apb_rlast           ),//
		.axi_s_rvalid     (apb_rvalid          ),//
		.axi_s_rready     (apb_rready          ),//

		.apb_valid_cpu    (apb_valid           ),
		.apb_clk          (                    ),
		.apb_reset_n      (apb_reset_n         ),
		.reg_psel         (apb_psel            ),
		.reg_enable       (apb_enab            ),
		.reg_rw           (apb_rw              ),
		.reg_addr         (apb_addr            ),
		.reg_datai        (apb_datai           ),
		.reg_ready_1      (apb_ack             ),
		.reg_datao        (apb_datao           )
    );

	apb_mux9 A_apb_mux_cpu
	(
		.apb_ack_cpu      (apb_ack             ),
		.apb_rw_cpu       (apb_rw              ),
		.apb_psel_cpu     (apb_psel            ),
		.apb_enab_cpu     (apb_enab            ),
		.apb_addr_cpu     (apb_addr            ),
		.apb_datai_cpu    (apb_datai           ),
		.apb_datao_cpu    (apb_datao           ),
		.apb_valid_cpu    (apb_valid           ),
		.apb0_req         (                    ),            
		.apb0_ack         (apb0_ack            ),
		.apb0_rw          (apb0_pwrite         ),
		.apb0_psel        (apb0_psel           ),
		.apb0_enab        (apb0_penable        ),
		.apb0_addr        (apb0_paddr          ),
		.apb0_datai       (apb0_pwdata         ),
		.apb0_datao       (apb0_prdata         ),

		.apb1_req         (                    ),            
		.apb1_ack         (apb1_ack            ),
		.apb1_rw          (apb1_pwrite         ),
		.apb1_psel        (apb1_psel           ),
		.apb1_enab        (apb1_penable        ),
		.apb1_addr        (apb1_paddr          ),
		.apb1_datai       (apb1_pwdata         ),
		.apb1_datao       (apb1_prdata         ),

		.apb2_req         (                    ),            
		.apb2_ack         (apb2_ack            ),
		.apb2_rw          (apb2_pwrite         ),
		.apb2_psel        (apb2_psel           ),
		.apb2_enab        (apb2_penable        ),
		.apb2_addr        (apb2_paddr          ),
		.apb2_datai       (apb2_pwdata         ),
		.apb2_datao       (apb2_prdata         ),

		.apb3_req         (                    ),            
		.apb3_ack         (apb3_ack            ),
		.apb3_rw          (apb3_pwrite         ),
		.apb3_psel        (apb3_psel           ),
		.apb3_enab        (apb3_penable        ),
		.apb3_addr        (apb3_paddr          ),
		.apb3_datai       (apb3_pwdata         ),
		.apb3_datao       (apb3_prdata         ),

		.apb4_req         (                    ),            
		.apb4_ack         (apb4_ack            ),
		.apb4_rw          (apb4_pwrite         ),
		.apb4_psel        (apb4_psel           ),
		.apb4_enab        (apb4_penable        ),
		.apb4_addr        (apb4_paddr          ),
		.apb4_datai       (apb4_pwdata         ),
		.apb4_datao       (apb4_prdata         ),

		.apb5_req         (                    ),            
		.apb5_ack         (apb5_ack            ),
		.apb5_rw          (apb5_pwrite         ),
		.apb5_psel        (apb5_psel           ),
		.apb5_enab        (apb5_penable        ),
		.apb5_addr        (apb5_paddr          ),
		.apb5_datai       (apb5_pwdata         ),
		.apb5_datao       (apb5_prdata         ),

		.apb6_req         (                    ),            
		.apb6_ack         (apb6_ack            ),
		.apb6_rw          (apb6_pwrite         ),
		.apb6_psel        (apb6_psel           ),
		.apb6_enab        (apb6_penable        ),
		.apb6_addr        (apb6_paddr          ),
		.apb6_datai       (apb6_pwdata         ),
		.apb6_datao       (apb6_prdata         ),

		.apb7_req         (                    ),            
		.apb7_ack         (apb7_ack            ),
		.apb7_rw          (apb7_pwrite         ),
		.apb7_psel        (apb7_psel           ),
		.apb7_enab        (apb7_penable        ),
		.apb7_addr        (apb7_paddr          ),
		.apb7_datai       (apb7_pwdata         ),
		.apb7_datao       (apb7_prdata         ),
		.apb8_req         (                    ),
            
		.apb8_ack         (apb8_ack            ),
		.apb8_rw          (apb8_pwrite         ),
		.apb8_psel        (apb8_psel           ),
		.apb8_enab        (apb8_penable        ),
		.apb8_addr        (apb8_paddr          ),
		.apb8_datai       (apb8_pwdata         ),
		.apb8_datao       (apb8_prdata         )
	);

endmodule // godson_mcu_cpu


module Dram_8k (DO, AD, STRB, CLKin, DI, EN, R_WB, reset);

    parameter NB = 32;  // Number of Data Bits
    parameter NA = 32;  // Number of Address Bits
    parameter NW = 2048;  // Number of WORDS    32*2048*16/8=8K

    output [(NB - 1) : 0] DO;

    input [(NB - 1) : 0] DI;
    input [      3  : 0] STRB;
    input [(NA - 1) : 0] AD;
    input EN;
    input R_WB;
    input CLKin;
	input reset;
    
	/*
	wire [3:0] wea = {4{R_WB}} & STRB;
    blk_mem_gen_1 ram_8k_inst ( 
		.clka        (CLKin    ),
		.ena         (EN       ),
		.wea         (wea      ),
		.addra       (AD[(NA - 1):2] ),    
		.dina        (DI       ),
		.douta       (DO       )
    );
	*/

    blk_mem_gen_1 ram_8k_inst(
        .dout(DO), //output [31:0] dout
        .clk(CLKin), //input clk
        .oce(EN), //input oce
        .ce(EN), //input ce
        .reset(~reset), //input reset
        // .reset(1'b0),
        .wre(R_WB), //input wre
        .ad(AD[12 : 2]), //input [10:0] ad
        .din(DI), //input [31:0] din
        .byte_en(4'b1111) //input [3:0] byte_en
    );
endmodule

module Flash_128k (DO, AD, STRB, CLKin, DI, EN, R_WB, reset);  

    parameter NB = 32;  // Number of Data Bits
    parameter NA = 32;  // Number of Address Bits
    parameter NW = 32768;  // Number of WORDS      32*32768*16/8=128K

    output [(NB - 1) : 0] DO;

    input [(NB - 1) : 0] DI;
    input [      3  : 0] STRB;
    input [(NA - 1) : 0] AD;
    input EN;
    input R_WB;
    input CLKin;
	input reset;

	/*
	wire [3:0] wea = {4{R_WB}} & STRB;
	blk_mem_gen_0 flash_128k_inst ( 
		.clka        (CLKin    ),
		.ena         (EN       ),
		.wea         (wea      ),
		.addra       (AD[(NA - 1):2] ),     
		.dina        (DI       ),
		.douta       (DO       )
    );
	*/

	blk_mem_gen_0 flash_128k_inst(
		.dout(DO), //output [31:0] dout
		.clk(CLKin), //input clk
		.oce(EN), //input oce
		.ce(EN), //input ce
		.reset(~reset), //input reset
		// .reset(1'b0),
		.wre(R_WB), //input wre
		//.wre(1'b0), //input wre
		.ad(AD[16 : 2]), //input [14:0] ad
		.din(DI), //input [31:0] din
		// .byte_en(byte_en_i) //input [3:0] byte_en
		.byte_en(4'b1111) //input [3:0] byte_en
	);

endmodule