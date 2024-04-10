//Copyright (C)2014-2023 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: IP file
//Tool Version: V1.9.9 (64-bit)
//Part Number: GW5AST-LV138PG484AES
//Device: GW5AST-138B
//Device Version: B
//Created Time: Wed Dec 27 14:14:34 2023

module blk_mem_gen_1 (dout, clk, oce, ce, reset, wre, ad, din, byte_en);

output [31:0] dout;
input clk;
input oce;
input ce;
input reset;
input wre;
input [10:0] ad;
input [31:0] din;
input [3:0] byte_en;

wire [15:0] sp_inst_0_dout_w;
wire [15:0] sp_inst_0_dout;
wire [15:0] sp_inst_1_dout_w;
wire [15:0] sp_inst_1_dout;
wire [15:0] sp_inst_2_dout_w;
wire [31:16] sp_inst_2_dout;
wire [15:0] sp_inst_3_dout_w;
wire [31:16] sp_inst_3_dout;
wire dff_q_0;
wire gw_gnd;

assign gw_gnd = 1'b0;

SP sp_inst_0 (
    .DO({sp_inst_0_dout_w[15:0],sp_inst_0_dout[15:0]}),
    .CLK(clk),
    .OCE(oce),
    .CE(ce),
    .RESET(reset),
    .WRE(wre),
    .BLKSEL({gw_gnd,gw_gnd,ad[10]}),
    .AD({ad[9:0],gw_gnd,gw_gnd,byte_en[1:0]}),
    .DI({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,din[15:0]})
);

defparam sp_inst_0.READ_MODE = 1'b0;
defparam sp_inst_0.WRITE_MODE = 2'b01;
defparam sp_inst_0.BIT_WIDTH = 16;
defparam sp_inst_0.BLK_SEL = 3'b000;
defparam sp_inst_0.RESET_MODE = "SYNC";

SP sp_inst_1 (
    .DO({sp_inst_1_dout_w[15:0],sp_inst_1_dout[15:0]}),
    .CLK(clk),
    .OCE(oce),
    .CE(ce),
    .RESET(reset),
    .WRE(wre),
    .BLKSEL({gw_gnd,gw_gnd,ad[10]}),
    .AD({ad[9:0],gw_gnd,gw_gnd,byte_en[1:0]}),
    .DI({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,din[15:0]})
);

defparam sp_inst_1.READ_MODE = 1'b0;
defparam sp_inst_1.WRITE_MODE = 2'b01;
defparam sp_inst_1.BIT_WIDTH = 16;
defparam sp_inst_1.BLK_SEL = 3'b001;
defparam sp_inst_1.RESET_MODE = "SYNC";

SP sp_inst_2 (
    .DO({sp_inst_2_dout_w[15:0],sp_inst_2_dout[31:16]}),
    .CLK(clk),
    .OCE(oce),
    .CE(ce),
    .RESET(reset),
    .WRE(wre),
    .BLKSEL({gw_gnd,gw_gnd,ad[10]}),
    .AD({ad[9:0],gw_gnd,gw_gnd,byte_en[3:2]}),
    .DI({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,din[31:16]})
);

defparam sp_inst_2.READ_MODE = 1'b0;
defparam sp_inst_2.WRITE_MODE = 2'b01;
defparam sp_inst_2.BIT_WIDTH = 16;
defparam sp_inst_2.BLK_SEL = 3'b000;
defparam sp_inst_2.RESET_MODE = "SYNC";

SP sp_inst_3 (
    .DO({sp_inst_3_dout_w[15:0],sp_inst_3_dout[31:16]}),
    .CLK(clk),
    .OCE(oce),
    .CE(ce),
    .RESET(reset),
    .WRE(wre),
    .BLKSEL({gw_gnd,gw_gnd,ad[10]}),
    .AD({ad[9:0],gw_gnd,gw_gnd,byte_en[3:2]}),
    .DI({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,din[31:16]})
);

defparam sp_inst_3.READ_MODE = 1'b0;
defparam sp_inst_3.WRITE_MODE = 2'b01;
defparam sp_inst_3.BIT_WIDTH = 16;
defparam sp_inst_3.BLK_SEL = 3'b001;
defparam sp_inst_3.RESET_MODE = "SYNC";

DFFRE dff_inst_0 (
  .Q(dff_q_0),
  .D(ad[10]),
  .CLK(clk),
  .CE(ce),
  .RESET(gw_gnd)
);
MUX2 mux_inst_0 (
  .O(dout[0]),
  .I0(sp_inst_0_dout[0]),
  .I1(sp_inst_1_dout[0]),
  .S0(dff_q_0)
);
MUX2 mux_inst_1 (
  .O(dout[1]),
  .I0(sp_inst_0_dout[1]),
  .I1(sp_inst_1_dout[1]),
  .S0(dff_q_0)
);
MUX2 mux_inst_2 (
  .O(dout[2]),
  .I0(sp_inst_0_dout[2]),
  .I1(sp_inst_1_dout[2]),
  .S0(dff_q_0)
);
MUX2 mux_inst_3 (
  .O(dout[3]),
  .I0(sp_inst_0_dout[3]),
  .I1(sp_inst_1_dout[3]),
  .S0(dff_q_0)
);
MUX2 mux_inst_4 (
  .O(dout[4]),
  .I0(sp_inst_0_dout[4]),
  .I1(sp_inst_1_dout[4]),
  .S0(dff_q_0)
);
MUX2 mux_inst_5 (
  .O(dout[5]),
  .I0(sp_inst_0_dout[5]),
  .I1(sp_inst_1_dout[5]),
  .S0(dff_q_0)
);
MUX2 mux_inst_6 (
  .O(dout[6]),
  .I0(sp_inst_0_dout[6]),
  .I1(sp_inst_1_dout[6]),
  .S0(dff_q_0)
);
MUX2 mux_inst_7 (
  .O(dout[7]),
  .I0(sp_inst_0_dout[7]),
  .I1(sp_inst_1_dout[7]),
  .S0(dff_q_0)
);
MUX2 mux_inst_8 (
  .O(dout[8]),
  .I0(sp_inst_0_dout[8]),
  .I1(sp_inst_1_dout[8]),
  .S0(dff_q_0)
);
MUX2 mux_inst_9 (
  .O(dout[9]),
  .I0(sp_inst_0_dout[9]),
  .I1(sp_inst_1_dout[9]),
  .S0(dff_q_0)
);
MUX2 mux_inst_10 (
  .O(dout[10]),
  .I0(sp_inst_0_dout[10]),
  .I1(sp_inst_1_dout[10]),
  .S0(dff_q_0)
);
MUX2 mux_inst_11 (
  .O(dout[11]),
  .I0(sp_inst_0_dout[11]),
  .I1(sp_inst_1_dout[11]),
  .S0(dff_q_0)
);
MUX2 mux_inst_12 (
  .O(dout[12]),
  .I0(sp_inst_0_dout[12]),
  .I1(sp_inst_1_dout[12]),
  .S0(dff_q_0)
);
MUX2 mux_inst_13 (
  .O(dout[13]),
  .I0(sp_inst_0_dout[13]),
  .I1(sp_inst_1_dout[13]),
  .S0(dff_q_0)
);
MUX2 mux_inst_14 (
  .O(dout[14]),
  .I0(sp_inst_0_dout[14]),
  .I1(sp_inst_1_dout[14]),
  .S0(dff_q_0)
);
MUX2 mux_inst_15 (
  .O(dout[15]),
  .I0(sp_inst_0_dout[15]),
  .I1(sp_inst_1_dout[15]),
  .S0(dff_q_0)
);
MUX2 mux_inst_16 (
  .O(dout[16]),
  .I0(sp_inst_2_dout[16]),
  .I1(sp_inst_3_dout[16]),
  .S0(dff_q_0)
);
MUX2 mux_inst_17 (
  .O(dout[17]),
  .I0(sp_inst_2_dout[17]),
  .I1(sp_inst_3_dout[17]),
  .S0(dff_q_0)
);
MUX2 mux_inst_18 (
  .O(dout[18]),
  .I0(sp_inst_2_dout[18]),
  .I1(sp_inst_3_dout[18]),
  .S0(dff_q_0)
);
MUX2 mux_inst_19 (
  .O(dout[19]),
  .I0(sp_inst_2_dout[19]),
  .I1(sp_inst_3_dout[19]),
  .S0(dff_q_0)
);
MUX2 mux_inst_20 (
  .O(dout[20]),
  .I0(sp_inst_2_dout[20]),
  .I1(sp_inst_3_dout[20]),
  .S0(dff_q_0)
);
MUX2 mux_inst_21 (
  .O(dout[21]),
  .I0(sp_inst_2_dout[21]),
  .I1(sp_inst_3_dout[21]),
  .S0(dff_q_0)
);
MUX2 mux_inst_22 (
  .O(dout[22]),
  .I0(sp_inst_2_dout[22]),
  .I1(sp_inst_3_dout[22]),
  .S0(dff_q_0)
);
MUX2 mux_inst_23 (
  .O(dout[23]),
  .I0(sp_inst_2_dout[23]),
  .I1(sp_inst_3_dout[23]),
  .S0(dff_q_0)
);
MUX2 mux_inst_24 (
  .O(dout[24]),
  .I0(sp_inst_2_dout[24]),
  .I1(sp_inst_3_dout[24]),
  .S0(dff_q_0)
);
MUX2 mux_inst_25 (
  .O(dout[25]),
  .I0(sp_inst_2_dout[25]),
  .I1(sp_inst_3_dout[25]),
  .S0(dff_q_0)
);
MUX2 mux_inst_26 (
  .O(dout[26]),
  .I0(sp_inst_2_dout[26]),
  .I1(sp_inst_3_dout[26]),
  .S0(dff_q_0)
);
MUX2 mux_inst_27 (
  .O(dout[27]),
  .I0(sp_inst_2_dout[27]),
  .I1(sp_inst_3_dout[27]),
  .S0(dff_q_0)
);
MUX2 mux_inst_28 (
  .O(dout[28]),
  .I0(sp_inst_2_dout[28]),
  .I1(sp_inst_3_dout[28]),
  .S0(dff_q_0)
);
MUX2 mux_inst_29 (
  .O(dout[29]),
  .I0(sp_inst_2_dout[29]),
  .I1(sp_inst_3_dout[29]),
  .S0(dff_q_0)
);
MUX2 mux_inst_30 (
  .O(dout[30]),
  .I0(sp_inst_2_dout[30]),
  .I1(sp_inst_3_dout[30]),
  .S0(dff_q_0)
);
MUX2 mux_inst_31 (
  .O(dout[31]),
  .I0(sp_inst_2_dout[31]),
  .I1(sp_inst_3_dout[31]),
  .S0(dff_q_0)
);
endmodule //blk_mem_gen_1
