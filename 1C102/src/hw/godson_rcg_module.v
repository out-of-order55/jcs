`ifdef FPGA 
    `define SIMU_TECH
    `define SIMU_ICG
`endif

module godson_rcg_module(
    input           dotestn,
    output          test_mode,
    output          osc32k_clkout_test,
    input           scan_clk,
    input           scan_cke_32k,
    input           scan_en,
    input           clk_ext32k,
    input           clk_ext8m,
    input           sys_rstn_i,
    input           por_rstn_i,
    input           wdt_rstn_i,
    output          por_wdtn_o,
    output [1:0]    rst_src_o,

    output          clk_32k,
    output          resetn_32k,
    output          por_rstn_o,

    output [1:0]    ck32k_sts,
    input [5:0]     ck32k_cfg
);
   wire [3:0]       ck32k_trim  = ck32k_cfg[3:0];
   wire             ck32k_speed = ck32k_cfg[4];
   wire             cksel_32k   = ck32k_cfg[5];

   wire             osc32k_clkout;
   dotest_sync A_dotest_sync(.dotest_in(~dotestn), .clock(osc32k_clkout), .dotest_out(test_mode), .arstn(por_rstn_i)); //filtered version

   wire             clk_int32k;
   wire             sysresetn_flt;
   reset_sync A_rst_filter(.rstn_in(sys_rstn_i), .clock(clk_int32k), .rstn_out(sysresetn_flt), .test_mode(test_mode), .arstn(por_rstn_o));

   wire             por_rstn = test_mode ? sys_rstn_i : por_rstn_i;
   assign           por_rstn_o = por_rstn;
   wire             wdt_rstn;
   wire             clk32k_test;
   TECH_CNMUX2 A_wdt_mux  (.D0(wdt_rstn_i), .D1(clk32k_test), .S0(test_mode), .Z(wdt_rstn));
          
   reg [1:0]        rst_src;
   wire             por_sys_rstn = test_mode ? sys_rstn_i : sysresetn_flt & por_rstn_i;
   always @(negedge wdt_rstn or negedge por_sys_rstn) begin
      if (~por_sys_rstn) rst_src <= 2'b0;
      else               rst_src <= {rst_src[0], ~rst_src[0]}; // 00 -> [ 01 -> 10 ]
   end
   assign           rst_src_o = rst_src;

   wire             sysresetn = test_mode ? sys_rstn_i : sysresetn_flt & por_rstn & wdt_rstn;
   wire             sysresetn_int32k;
   areset_sync A_srst_int32k(.rstn_in(sysresetn), .clock(clk_int32k), .rstn_out(sysresetn_int32k), .test_mode(test_mode));

   clk8m_32k CLK8M_to_32k_int ( .clk_i(clk_ext8m), .clk_o(osc32k_clkout), .rst_i(~sys_rstn_i));

   assign  osc32k_clkout_test = osc32k_clkout; //connect to PAD in test_osc mode.

   //TECH_CNAND2 A_scan_mux   (.A(scan_clk), .B(scan_cke_32k), .Z(clk32k_test));
   TECH_ICG A_scan_32k_cg  (.enable(scan_cke_32k), .ck_in(scan_clk), .ck_out(clk32k_test), .test(scan_en));

   TECH_CNMUX2 A_osc32k_mux (.D0(osc32k_clkout), .D1(clk32k_test), .S0(test_mode), .Z(clk_int32k));

   clock_select_32k A_cksel32k
     (
      .clk_ext32k (clk_ext32k       ),
      .clk_int32k (clk_int32k       ),
      .resetn     (sysresetn_int32k ),
      .clk_32k_o  (clk_32k          ),
      .status     (ck32k_sts        ),
      .select     (cksel_32k        ),
      .test_mode  (test_mode        )
      );

   reg [3:0]        reset_cnt;
   always @(posedge clk_32k or negedge sysresetn_int32k) begin
      if (~sysresetn_int32k ) reset_cnt <= 4'b0;
      else if (~reset_cnt[3]) reset_cnt <= reset_cnt + 4'b1;
   end

   assign resetn_32k = test_mode ? sysresetn : reset_cnt[3];

   assign por_wdtn_o = por_rstn & wdt_rstn;

endmodule // godson_rcg_module

module sync_module(async_in, clock, sync_out);

   parameter WIDTH=1;
   parameter NEGEDGE=1;

   input              clock;
   input  [WIDTH-1:0] async_in;
   output [WIDTH-1:0] sync_out;

   reg [WIDTH-1:0]    sync_stage0;
   reg [WIDTH-1:0]    sync_stage1;

   generate
      if (NEGEDGE) begin: stage0_negedge
         always @(negedge clock) begin // falling edge
            sync_stage0 <= async_in;
         end
      end else begin: stage0_posedge
         always @(posedge clock) begin // falling edge
            sync_stage0 <= async_in;
         end
      end
   endgenerate
   always @(posedge clock) begin // rising edge   --> reduce sync delay
      sync_stage1 <= sync_stage0;
   end
   assign sync_out = sync_stage1;

endmodule // sync_module

module areset_sync(rstn_in, clock, rstn_out, test_mode);
   input              clock;
   input              rstn_in;
   output             rstn_out;
   input              test_mode;

   parameter          STAGE=2;

//   reg                sync_stage0;
//   reg                sync_stage1;
//   reg                sync_stage2;
//   reg                sync_stage3;

   reg [STAGE -1:0] sync_stage;
    integer i;

   always @(posedge clock or negedge rstn_in) begin
      if (rstn_in == 1'b0) begin
        for(i=0; i<STAGE; i=i+1) sync_stage[i] <= 1'b0;
      end else begin
         sync_stage[0] <= 1'b1;
        for(i=1; i<STAGE; i=i+1) sync_stage[i] <= sync_stage[i-1];
      end
   end

   wire synced = sync_stage[STAGE-1];

   assign rstn_out = test_mode ? rstn_in : synced;

endmodule // areset_sync

module reset_sync(
    input   rstn_in,
    input   clock,
    output  rstn_out,
    input   arstn,
    input   test_mode
);
   reg [4:0] sync_reg;
   always@(posedge clock or negedge arstn) begin
      if (~arstn) begin
         sync_reg <= 5'b0;
      end else begin
         sync_reg <= {|sync_reg[3:1], sync_reg[2:0] , rstn_in};
      end
   end
   assign    rstn_out = test_mode ? rstn_in : sync_reg[4];
endmodule

module dotest_sync(
    input   dotest_in,
    input   clock,
    input   arstn,
    output  dotest_out // output dotest after 5cycle sync
);
   reg [4:0] sync_reg;
   always@(posedge clock or negedge arstn) begin
      if (~arstn) begin
         sync_reg <= 5'b0;
      end else begin
         sync_reg <= {&sync_reg[3:1], sync_reg[2:0], dotest_in};
      end
   end
   assign    dotest_out = sync_reg[4];
endmodule

module cpu_rcg(
    input           test_mode,
    input           scan_clk,
    input           scan_cke_32m,
    input           scan_cke_8m,
    input           scan_en,

    input           clk_ext8m,
    input           osc32m_clkout,
    input           resetn_i,

    input           cksel_8m,
    output [1:0]    cksts_8m,
    output          ck_is_8m,         

    input           cpu_turbo,           // synced with clk_cpu
    input           flash_rdy,
    output          clk_cpu,
    output          clk_bus,
    output          resetn_buscpu,
    output          sync_en,

    input [2:0]     vclk_cfg,
    output          vclk,
    output          vrstn   
);

   wire             clk_int32m_early;
   wire             clk_int32m;
   wire             clk_int8m;
   wire             resetn_int32m;
   wire             clk_328_early;
   wire             clk_328; // 32M or 8M
   
   wire clk_bus_t;

   areset_sync A_srst_int32m(.rstn_in(resetn_i), .clock(~clk_int32m), .rstn_out(resetn_int32m), .test_mode(test_mode));

   wire clk32m_test;
   TECH_ICG A_scan_clk_cg  (.enable(scan_cke_32m), .ck_in(scan_clk), .ck_out(clk32m_test), .test(scan_en));
   TECH_CNMUX2 A_osc32m_mux (.D0(osc32m_clkout), .D1(clk32m_test), .S0(test_mode), .Z(clk_int32m_early));
   TECH_CNBUF  A_int32m_buf (.A(clk_int32m_early), .Z(clk_int32m));

   // init clock, reset to div4 mode, once flash_rdy is sampled, switch off div4 and open bypass mode
   reg [2:0]        pclk_cnt;
   reg [2:0]        pclk_cnt1;
   reg              rdy_r;
   always @(posedge clk_int32m or negedge resetn_int32m) begin  // CDC: no need to sync, resetn_in rise -> clk32m = 1.5us
      if (~resetn_int32m) begin
         pclk_cnt <= 3'b00;
         pclk_cnt1<= 3'b00;
         rdy_r    <= 1'b0;
      end else if (pclk_cnt[2:0] == 3'b011 && rdy_r) begin
         pclk_cnt <= 3'b100;
         pclk_cnt1<= 3'b100;
      end else if (pclk_cnt[2:0] == 3'b100) begin
         pclk_cnt <= 3'b101;
         pclk_cnt1<= 3'b101;
      end else if (~pclk_cnt[2]) begin
         pclk_cnt[1:0] <= pclk_cnt[1:0] + 1'b1;
         pclk_cnt1[1:0]<= pclk_cnt[1:0] + 1'b1;
         rdy_r         <= flash_rdy;
      end else begin
         pclk_cnt <= pclk_cnt;
         pclk_cnt1<= pclk_cnt;
      end
   end
   wire             pclk_passthru = (pclk_cnt == 3'b101);
   wire             clk_int32m_g;
   wire             clk_int;
   TECH_CNMUX2 A_int8_m(.D0(pclk_cnt1[1]), .D1(1'b0), .S0(test_mode), .Z(clk_int8m));
   TECH_ICG   A_pclk_cg(.enable(pclk_passthru), .ck_in(clk_int32m_early), .ck_out(clk_int32m_g), .test(test_mode));
   TECH_CNOR2 A_pclk_or(.A(clk_int32m_g), .B(clk_int8m), .Z(clk_int));


   wire             using_extclk;
   wire             ckmux_selint;
   assign           using_extclk = test_mode | ~ckmux_selint;
   clock_select_328 A_cksel
     (
      .clk_ext8m  (clk_ext8m     ),
      .clk_int8m  (clk_int       ),
      .resetn     (resetn_int32m ),
      .clk_328_o  (clk_328_early ),
      .status     (cksts_8m      ),
      .intclk_sel (ckmux_selint  ),
      .select     (cksel_8m      ),
      .test_mode  (test_mode     )
      );
   TECH_CNBUF  A_clk328_buf (.A(clk_328_early), .Z(clk_328));
   
   wire             rdy_latch;
   TECH_LATCH i_lockup_rdy_r (.Q(rdy_latch), .D(rdy_r), .EN(clk_int32m));
   assign           ck_is_8m = using_extclk | ~rdy_latch; // both in int clock domain

   wire             freq_sel = rdy_r ? 1'b1 : 1'b0;
   reg [1:0]        bus_cnt;
   wire             bus_cnt_arstn = test_mode ? resetn_int32m : resetn_int32m & ckmux_selint;
   always @(posedge clk_328 or negedge bus_cnt_arstn) begin
      if (~bus_cnt_arstn) bus_cnt <= 2'b00; // reset cnt when external 8m is used
      else if (rdy_r    ) bus_cnt <= {bus_cnt[0], ~|bus_cnt[1:0]}; // 1/3
   end
   wire             bus_cke = ~rdy_r | (bus_cnt[1:0] == 2'b01)   | using_extclk;
   wire             cpu_cke = ~rdy_r | resetn_int32m & cpu_turbo | bus_cke;
   TECH_ICG A_cpu_clk_chop (.enable(cpu_cke), .ck_in(clk_328_early), .ck_out(clk_cpu),   .test(test_mode));
   TECH_ICG A_bus_clk_chop (.enable(bus_cke), .ck_in(clk_328_early), .ck_out(clk_bus_t), .test(test_mode));

   wire             bus_cnt_1;
   TECH_CNMUX2 A_bcnt_m(.D0(bus_cnt[1]), .D1(1'b0), .S0(test_mode), .Z(bus_cnt_1));
   TECH_CNOR2 A_bus_clk_or (.A(clk_bus_t), .B(bus_cnt_1), .Z(clk_bus));

   areset_sync #(4) A_srst_buscpu(.rstn_in(resetn_int32m), .clock(clk_bus), .rstn_out(resetn_buscpu), .test_mode(test_mode));

   //assign sync_en = bus_cke;
   TECH_LATCH i_lockup_syncen (.Q(sync_en), .D(bus_cke), .EN(clk_328_early));


   reg [2:0]        reset_cnt;
   always @(posedge clk_int32m or negedge resetn_int32m) begin
      if (~resetn_int32m )     reset_cnt <= 3'b0;
      else if (~reset_cnt[2]) reset_cnt <= reset_cnt + 3'b1;
   end

   wire   resetn_8m;
   assign resetn_8m = test_mode ? resetn_int32m : reset_cnt[2];

   wire             vcfg_rst   = vclk_cfg[0];
   wire             vcfg_sel8m = vclk_cfg[1] | test_mode;
   TECH_CNMUX2 A_vclk_mux (.D0(clk_int32m), .D1(clk_bus), .S0(vcfg_sel8m), .Z(vclk));
   reg [1:0]        vrstn_syn_v;
   always @(posedge vclk or negedge resetn_8m) begin
      if (~resetn_8m) vrstn_syn_v <= 2'b0;
      else            vrstn_syn_v <= {vrstn_syn_v[0], ~vcfg_rst};
   end
   assign           vrstn = test_mode ? resetn_int32m : vrstn_syn_v[1];

endmodule // cpu_rcg

module clock_select_32k(
    input           clk_ext32k,
    input           clk_int32k,
    input           resetn,
    output          clk_32k_o,
    output [1:0]    status,     //[1]: failed
                                //[0]: current select
    input           select,     // fall: int32k,  rise: ext32k
    input           test_mode
);

   assign status[1] = 1'b1;
   assign status[0] = 1'b0;

   assign clk_32k_o = clk_int32k;

endmodule // clock_select_32k

module clock_select_328(
    input           clk_ext8m,
    input           clk_int8m,
    input           resetn,
    output          clk_328_o,
    output [1:0]    status,     //[1]: failed
                                //[0]: current select
    output          intclk_sel,         
    input           select,     // fall: int8m,  rise: ext8m
    input           test_mode
);
   reg  [3:0]       stat;
   wire [3:0]       stat_d   = gray2bin(stat);
   wire [3:0]       stat_inc = stat_d + 1'b1;
   wire [3:0]       stat_nxt = bin2gray(stat_inc);

   always @(posedge clk_int8m or negedge resetn) begin
      if (~resetn) stat <= 4'b00;
      else         stat <= stat_nxt;
   end

   wire             stat_reset  = (stat == 4'b0000);
   wire             stat_sample = (stat == 4'b1000);

   reg              ext_alive;
   wire             arstn = test_mode ? resetn : ~stat_reset;
   always @(posedge clk_ext8m or negedge arstn) begin
      if (~arstn) ext_alive <= 1'b0;
      else        ext_alive <= 1'b1;
   end
   reg [1:0]        clk_alive;
   always @(posedge clk_int8m or negedge resetn) begin
      if (~resetn)          clk_alive <= 2'b00;
      else if (stat_sample) clk_alive <= {clk_alive[0], ext_alive};
   end

   reg [2:0]        sel_v;
   always @(posedge clk_int8m) sel_v[2:0] <= {sel_v[1:0], select};

   wire             go_int = (sel_v[2:1] == 2'b10);
   wire             go_ext = (sel_v[2:1] == 2'b01);

   reg              clk_sel;
   always @(posedge clk_int8m or negedge resetn) begin
      if (~resetn) begin
         clk_sel <= 1'b0;
      end else if (clk_alive[1] & go_ext) begin
         clk_sel <= 1'b1;
      end else if (clk_alive[1] & go_int) begin
         clk_sel <= 1'b0;
      end else if (~clk_alive[1]) begin
         clk_sel <= 1'b0;
      end
   end

   wire       gfm_clkb_sel;
   TECH_LATCH i_lockup_sts1 (.Q(status[1] ), .D(~clk_alive[1]), .EN(clk_int8m));
   TECH_LATCH i_lockup_sts0 (.Q(status[0] ), .D(clk_sel      ), .EN(clk_int8m));
   TECH_LATCH i_lockup_cksel(.Q(intclk_sel), .D(gfm_clkb_sel ), .EN(clk_int8m));

   // clock switch logic
   gfmux I_gfm(.clka_i(clk_ext8m), .clkb_i(clk_int8m),
               .sela_i(clk_sel), .clka_off_o(), .nrst_i(resetn),
               .clk_o(clk_328_o), .clkb_sel_o(gfm_clkb_sel), .test_mode(test_mode));
               
   function [3:0] bin2gray;
      input [3:0]  bin;
      integer           n;
      begin
         for (n=0; n<3; n=n+1)
           bin2gray[n] = bin[n+1] ^ bin[n];

         bin2gray[3] = bin[3];
      end
   endfunction

   function [3:0] gray2bin;
      input [3:0]  gray;
      integer           n;
      begin
         for (n=0; n<=3; n=n+1)
           gray2bin[n] = ^(gray>>n);
      end
   endfunction

endmodule // clock_select_328
`ifdef __FULL_SRC__
module ext8m_check(
    input           clk_ext8m,
    input           clk_32k,
    input           resetn,
    output          ext8m_ok,
    input           chk_rst,
    input           chk_smp,
    input           test_mode
);
   reg              stat;
   always @(posedge clk_32k) begin
      if (~resetn | chk_rst) stat <= 1'b0;
      else if (chk_smp     ) stat <=~stat; // auto reset & sample sequence starts after chk_smp
   end

   wire             stat_reset  = (stat == 1'b1) | chk_rst;
   wire             stat_sample = chk_smp ? (stat == 1'b0) : 1'b1;

   reg              ext_alive;
   wire             arstn = test_mode ? resetn : ~stat_reset;
   always @(posedge clk_ext8m or negedge arstn) begin
      if (~arstn) ext_alive <= 1'b0;
      else        ext_alive <= 1'b1;
   end
   reg              clk_alive;
   always @(posedge clk_32k or negedge resetn) begin
      if (~resetn)          clk_alive <= 1'b0;
      else if (stat_sample) clk_alive <= ext_alive;
   end

   assign ext8m_ok = clk_alive;

endmodule
`endif
module gfmux(
    input  clka_i, // 
    input  clkb_i, // always on default clock
    input  sela_i, // reset to 0
    input  nrst_i, // async reset
    output clka_off_o, // clka is off
    output clkb_sel_o, // final mux sel info
    output clk_o,
    input  test_mode
);
   parameter TIMEOUT = 8;
   wire   clka_en_in;
   wire   clkb_en_in;

   wire   clka_en;
   wire   clkb_en;

   wire   nrst_a;
   wire   nrst_b;
   areset_sync rst_a(.rstn_in(nrst_i), .clock(clka_i), .rstn_out(nrst_a), .test_mode(test_mode));
   areset_sync rst_b(.rstn_in(nrst_i), .clock(clkb_i), .rstn_out(nrst_b), .test_mode(test_mode));
   // TODO: check register implementation to ensure wild clock will not
   //       result state transition, while D input match with the internal state.
   reg [2:0] clka_en_v;
   always @(posedge clka_i or negedge nrst_a) begin
      if (~nrst_a) begin
         clka_en_v[2:0] <= 3'b0;
      end else begin
         clka_en_v[2:0] <= {clka_en_v[1:0], clka_en_in};
      end
   end

   reg [2:0] clkb_en_v;
   always @(posedge clkb_i or negedge nrst_b) if (~nrst_b) clkb_en_v[0] <= 1'b1; else clkb_en_v[0] <= clkb_en_in;
   always @(negedge clkb_i or negedge nrst_b) if (~nrst_b) clkb_en_v[1] <= 1'b1; else clkb_en_v[1] <= clkb_en_v[0];
   always @(posedge clkb_i or negedge nrst_b) if (~nrst_b) clkb_en_v[2] <= 1'b1; else clkb_en_v[2] <= clkb_en_v[1];

   wire      selb_sync;
   sync_module i_selb_sync (.async_in(~sela_i), .clock(clkb_i), .sync_out(selb_sync));
   reg [3:0] clkb_timeout_cnt;
   wire      clkb_timeout = clkb_timeout_cnt[3] & selb_sync;
   wire [3:0]toinc_step = (TIMEOUT >= 8) ? 4'd1 :
                          (TIMEOUT >= 4) ? 4'd2 :
                          (TIMEOUT >= 2) ? 4'd4 :
                                           4'd8;

   always@(negedge clkb_i or negedge nrst_b) begin
      if (~nrst_b) begin
         clkb_timeout_cnt <= 4'b0;
      end else if (selb_sync & ~clkb_timeout) begin
         clkb_timeout_cnt <= {1'b0, clkb_timeout_cnt[2:0]} + toinc_step;
      end else if(~selb_sync)begin
         clkb_timeout_cnt <= 4'b0;
      end
   end

   assign clka_en_in = ~clkb_en_v[2] & sela_i;
   assign clkb_en_in = ~clka_en_v[2] &~sela_i;

   assign clka_en = clka_en_v[1] ;
   assign clkb_en = clkb_en_v[1] | clkb_timeout;

   wire clka_gated;
   wire clkb_gated;
//   cg_module cg_a(.clock_in(clka_i), .enable(clka_en), .clock_out(clka_gated));
//   cg_module cg_b(.clock_in(clkb_i), .enable(clkb_en), .clock_out(clkb_gated));
   TECH_ICG  cg_a(.ck_in(clka_i),  .enable(clka_en),  .ck_out(clka_gated), .test(test_mode));
   TECH_ICG  cg_b(.ck_in(clkb_i),  .enable(clkb_en),  .ck_out(clkb_gated), .test(test_mode));

   wire clka_gand;
   TECH_CNAND2 band (.A(clka_gated), .B(~clkb_timeout), .Z(clka_gand));

   wire out_selb = |clkb_en_v[2:1] | clkb_timeout | test_mode;

   //assign clk_o   = out_selb ? clkb_gated : clka_gand;
   TECH_CNMUX2 omux (.D0(clka_gand), .D1(clkb_gated), .S0(out_selb), .Z(clk_o));
   assign clka_off_o = ~clka_en_v[2];
   assign clkb_sel_o = out_selb;

endmodule // gfmux

module cg_module (enable, clock_in, clock_out);
   input enable, clock_in;
   output clock_out;
   TECH_ICG cg(.enable(enable), .ck_in(clock_in), .ck_out(clock_out), .test(1'b0));
endmodule // cg_module

// technology dependant implementations
module TECH_ICG (enable, ck_in, ck_out, test);
   input enable, ck_in, test;
   output ck_out;
   
   reg    en;
   always @(ck_in or enable) begin
      if (~ck_in) en <= enable;
   end
   assign ck_out = en & ck_in;

endmodule 
/*
module TECH_DLY_4NS (in, out);
   input in;
   output out;
`ifdef SIMU_BEHAVIOUR_DELAY
   reg    r;
   always @(in) r = #4.0 in;
   assign out = r;
`else
   wire   t;
   gs_delay_2n_tapless_HHNEC130 d0(.IN(in), .INB(t  ));
   gs_delay_2n_tapless_HHNEC130 d1(.IN(t ), .INB(out));
`endif
endmodule

module TECH_INV_2NS (in, out);
   input in;
   output out;
`ifdef SIMU_BEHAVIOUR_DELAY
   reg    r;
   always @(in) r = #2.0 ~in;
   assign out = r;
`else
   gs_delay_2n_tapless_HHNEC130 dly2n(.IN(in), .INB(out));
`endif
endmodule
*/

module TECH_CNBUF (A, Z);
   input A;
   output Z;
`ifdef SIMU_TECH
   assign Z = A;
`else
   scs8lp_buf_16 buf2(.A(A), .X(Z));
`endif
endmodule

module TECH_CNAND2 (A, B, Z);
   input A, B;
   output Z;
`ifdef SIMU_TECH
   assign Z = A&B;
`else
   scs8lp_and2_2 and2(.A(A), .B(B), .X(Z));
`endif
endmodule // TECH_CNAND
`ifdef __FULL_SRC__
module TECH_CNNAND2 (A, B, Z);
   input A, B;
   output Z;
`ifdef SIMU_TECH
   assign Z = ~(A&B);
`else
   scs8lp_nand2_2 nand2(.A(A), .B(B), .Y(Z));
`endif
endmodule // TECH_CNAND
`endif
module TECH_CNOR2 (A, B, Z);
   input A, B;
   output Z;
`ifdef SIMU_TECH
   assign Z = A|B;
`else
   scs8lp_or2_2 or2(.A(A), .B(B), .X(Z));
`endif
endmodule // TECH_CNOR
module TECH_CNMUX2 (D0, D1, S0, Z);
   input D0, D1, S0;
   output Z;
`ifdef SIMU_TECH
   assign Z = S0 ? D1 : D0;
`else
   scs8lp_mux2_2 mux2(.A0(D0), .A1(D1), .S(S0), .X(Z));
`endif
endmodule // TECH_CNMUX2
`ifdef __FULL_SRC__
module TECH_CNDFF (D, Q, CP);
   input D, CP;
   output Q;
`ifdef SIMU_TECH
   reg    Q;
   always @(posedge CP) Q <= D;
`else
   scs8lp_dfxtp_2 dff(.D(D), .Q(Q), .CLK(CP));
`endif
endmodule // TECH_CNDFF
`endif
module TECH_CNDFFR (D, Q, CP, RN);
   input D, CP, RN;
   output Q;
`ifdef SIMU_TECH
   reg    Q;
   always @(posedge CP or negedge RN)
     if (~RN) Q <= 1'b0;
     else     Q <= D;
`else
   scs8lp_dfrtp_2 dfr(.D(D), .Q(Q), .CLK(CP), .RESETB(RN));
`endif
endmodule // TECH_CNDFFR
module TECH_CNXOR2 (A, S, Z);
   input A, S;
   output Z;
`ifdef SIMU_TECH
   assign Z = A^S;
`else
   scs8lp_xor2_2 xor2(.A(A), .B(S), .X(Z));
`endif
endmodule // TECH_CNXOR
`ifdef __FULL_SRC__
module TECH_CINV (A, Z);
   input A;
   output Z;
`ifdef SIMU_TECH
   assign Z = ~A;
`else
   scs8lp_clkinv_2 clkinv(.A(A), .Y(Z));
`endif
endmodule // TECH_CINV
module TECH_CNNOR2 (A, B, Z);
   input A, B;
   output Z;
`ifdef SIMU_TECH
   assign Z = ~(A|B);
`else
   scs8lp_nor2_2 nor2(.A(A), .B(B), .Y(Z));
`endif
endmodule // TECH_CNNOR2
`endif
module TECH_LATCH(
    input D, EN,
    output Q
);
   parameter delay = 0.010;
`ifdef SIMU_TECH
   reg       l;
   always @(*) begin
      if (EN==1'b0) l <= #delay D;
   end
   assign Q = l;
`else
   scs8lp_dlxtn_2 dl(.Q(Q), .D(D), .GATEN(EN));
`endif
endmodule // slib_dreg

module FUNC_CG_CELL(
    input  CKIN,
    input  EN,
    input  SE,
    output CKOUT
);
   TECH_ICG cg(.enable(EN), .ck_in(CKIN), .ck_out(CKOUT), .test(SE));
endmodule

module TECH_BUF ( buf_i, buf_o);
input buf_i;
output buf_o;
`ifdef SIMU_TECH
  assign buf_o = buf_i;
`else  
  scs8lp_buf_4 test_buf ( .A(buf_i), .X(buf_o) );
`endif
endmodule


module clk8m_32k(
input         clk_i,
input         rst_i,
(* dont_touch="true" *) output reg    clk_o
);

(* dont_touch="true" *)  reg [7:0] counter;
always@(posedge clk_i)
begin
    if(rst_i)
        counter <= 8'h0;
//    else if(counter != 8'd151)
    else if(counter != 8'd122)
        counter <= counter + 1'b1;
    else
        counter <= 8'h0;
end
always@(posedge clk_i)
begin
    if(rst_i)
        clk_o <= 1'b0;
//    else if(counter == 8'd151)
    else if(counter == 8'd122)
        clk_o <= ~clk_o;
end
endmodule
