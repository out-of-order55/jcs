//Copyright (C)2014-2023 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.9 (64-bit)
//Part Number: GW5AST-LV138PG484AES
//Device: GW5AST-138B
//Device Version: B
//Created Time: Wed Dec 27 14:14:34 2023

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    blk_mem_gen_1 your_instance_name(
        .dout(dout_o), //output [31:0] dout
        .clk(clk_i), //input clk
        .oce(oce_i), //input oce
        .ce(ce_i), //input ce
        .reset(reset_i), //input reset
        .wre(wre_i), //input wre
        .ad(ad_i), //input [10:0] ad
        .din(din_i), //input [31:0] din
        .byte_en(byte_en_i) //input [3:0] byte_en
    );

//--------Copy end-------------------
