module gw_gao(
    \A_cpu/A_la132/reset_Z ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_en ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_wr ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[16] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[15] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[14] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[13] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[12] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[11] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[10] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[9] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[8] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[7] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[6] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[5] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[4] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[3] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[2] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[31] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[30] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[29] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[28] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[27] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[26] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[25] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[24] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[23] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[22] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[21] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[20] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[19] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[18] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[17] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[16] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[15] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[14] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[13] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[12] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[11] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[10] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[9] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[8] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[7] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[6] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[5] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[4] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[3] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[2] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[1] ,
    \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[0] ,
    \A_cpu/data_sram_en ,
    \A_cpu/data_sram_wr ,
    \A_cpu/data_sram_addr[12] ,
    \A_cpu/data_sram_addr[11] ,
    \A_cpu/data_sram_addr[10] ,
    \A_cpu/data_sram_addr[9] ,
    \A_cpu/data_sram_addr[8] ,
    \A_cpu/data_sram_addr[7] ,
    \A_cpu/data_sram_addr[6] ,
    \A_cpu/data_sram_addr[5] ,
    \A_cpu/data_sram_addr[4] ,
    \A_cpu/data_sram_addr[3] ,
    \A_cpu/data_sram_addr[2] ,
    \A_cpu/data_sram_rdata[31] ,
    \A_cpu/data_sram_rdata[30] ,
    \A_cpu/data_sram_rdata[29] ,
    \A_cpu/data_sram_rdata[28] ,
    \A_cpu/data_sram_rdata[27] ,
    \A_cpu/data_sram_rdata[26] ,
    \A_cpu/data_sram_rdata[25] ,
    \A_cpu/data_sram_rdata[24] ,
    \A_cpu/data_sram_rdata[23] ,
    \A_cpu/data_sram_rdata[22] ,
    \A_cpu/data_sram_rdata[21] ,
    \A_cpu/data_sram_rdata[20] ,
    \A_cpu/data_sram_rdata[19] ,
    \A_cpu/data_sram_rdata[18] ,
    \A_cpu/data_sram_rdata[17] ,
    \A_cpu/data_sram_rdata[16] ,
    \A_cpu/data_sram_rdata[15] ,
    \A_cpu/data_sram_rdata[14] ,
    \A_cpu/data_sram_rdata[13] ,
    \A_cpu/data_sram_rdata[12] ,
    \A_cpu/data_sram_rdata[11] ,
    \A_cpu/data_sram_rdata[10] ,
    \A_cpu/data_sram_rdata[9] ,
    \A_cpu/data_sram_rdata[8] ,
    \A_cpu/data_sram_rdata[7] ,
    \A_cpu/data_sram_rdata[6] ,
    \A_cpu/data_sram_rdata[5] ,
    \A_cpu/data_sram_rdata[4] ,
    \A_cpu/data_sram_rdata[3] ,
    \A_cpu/data_sram_rdata[2] ,
    \A_cpu/data_sram_rdata[1] ,
    \A_cpu/data_sram_rdata[0] ,
    \A_cpu/data_sram_wdata[31] ,
    \A_cpu/data_sram_wdata[30] ,
    \A_cpu/data_sram_wdata[29] ,
    \A_cpu/data_sram_wdata[28] ,
    \A_cpu/data_sram_wdata[27] ,
    \A_cpu/data_sram_wdata[26] ,
    \A_cpu/data_sram_wdata[25] ,
    \A_cpu/data_sram_wdata[24] ,
    \A_cpu/data_sram_wdata[23] ,
    \A_cpu/data_sram_wdata[22] ,
    \A_cpu/data_sram_wdata[21] ,
    \A_cpu/data_sram_wdata[20] ,
    \A_cpu/data_sram_wdata[19] ,
    \A_cpu/data_sram_wdata[18] ,
    \A_cpu/data_sram_wdata[17] ,
    \A_cpu/data_sram_wdata[16] ,
    \A_cpu/data_sram_wdata[15] ,
    \A_cpu/data_sram_wdata[14] ,
    \A_cpu/data_sram_wdata[13] ,
    \A_cpu/data_sram_wdata[12] ,
    \A_cpu/data_sram_wdata[11] ,
    \A_cpu/data_sram_wdata[10] ,
    \A_cpu/data_sram_wdata[9] ,
    \A_cpu/data_sram_wdata[8] ,
    \A_cpu/data_sram_wdata[7] ,
    \A_cpu/data_sram_wdata[6] ,
    \A_cpu/data_sram_wdata[5] ,
    \A_cpu/data_sram_wdata[4] ,
    \A_cpu/data_sram_wdata[3] ,
    \A_cpu/data_sram_wdata[2] ,
    \A_cpu/data_sram_wdata[1] ,
    \A_cpu/data_sram_wdata[0] ,
    \A_cpu/A_la132/ifc2fetch_bus[31] ,
    \A_cpu/A_la132/ifc2fetch_bus[30] ,
    \A_cpu/A_la132/ifc2fetch_bus[29] ,
    \A_cpu/A_la132/ifc2fetch_bus[28] ,
    \A_cpu/A_la132/ifc2fetch_bus[27] ,
    \A_cpu/A_la132/ifc2fetch_bus[26] ,
    \A_cpu/A_la132/ifc2fetch_bus[25] ,
    \A_cpu/A_la132/ifc2fetch_bus[24] ,
    \A_cpu/A_la132/ifc2fetch_bus[23] ,
    \A_cpu/A_la132/ifc2fetch_bus[22] ,
    \A_cpu/A_la132/ifc2fetch_bus[21] ,
    \A_cpu/A_la132/ifc2fetch_bus[20] ,
    \A_cpu/A_la132/ifc2fetch_bus[19] ,
    \A_cpu/A_la132/ifc2fetch_bus[18] ,
    \A_cpu/A_la132/ifc2fetch_bus[17] ,
    \A_cpu/A_la132/ifc2fetch_bus[16] ,
    \A_cpu/A_la132/ifc2fetch_bus[15] ,
    \A_cpu/A_la132/ifc2fetch_bus[14] ,
    \A_cpu/A_la132/ifc2fetch_bus[13] ,
    \A_cpu/A_la132/ifc2fetch_bus[12] ,
    \A_cpu/A_la132/ifc2fetch_bus[11] ,
    \A_cpu/A_la132/ifc2fetch_bus[10] ,
    \A_cpu/A_la132/ifc2fetch_bus[9] ,
    \A_cpu/A_la132/ifc2fetch_bus[8] ,
    \A_cpu/A_la132/ifc2fetch_bus[7] ,
    \A_cpu/A_la132/ifc2fetch_bus[6] ,
    \A_cpu/A_la132/ifc2fetch_bus[5] ,
    \A_cpu/A_la132/ifc2fetch_bus[4] ,
    \A_cpu/A_la132/ifc2fetch_bus[3] ,
    \A_cpu/A_la132/ifc2fetch_bus[2] ,
    \A_cpu/A_la132/ifc2fetch_bus[1] ,
    \A_cpu/A_la132/ifc2fetch_bus[0] ,
    \A_cpu/A_axi2apb/state[1] ,
    \A_cpu/A_axi2apb/state[0] ,
    \A_cpu/A_axi2apb/valid ,
    \A_cpu/A_axi2apb/busy ,
    pll_lock,
    clk_ext8m,
    tms_pad_i,
    tck_pad_i,
    tdi_pad_i,
    tdo_pad_o
);

input \A_cpu/A_la132/reset_Z ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_en ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_wr ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[16] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[15] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[14] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[13] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[12] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[11] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[10] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[9] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[8] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[7] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[6] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[5] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[4] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[3] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[2] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[31] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[30] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[29] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[28] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[27] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[26] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[25] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[24] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[23] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[22] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[21] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[20] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[19] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[18] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[17] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[16] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[15] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[14] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[13] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[12] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[11] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[10] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[9] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[8] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[7] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[6] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[5] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[4] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[3] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[2] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[1] ;
input \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[0] ;
input \A_cpu/data_sram_en ;
input \A_cpu/data_sram_wr ;
input \A_cpu/data_sram_addr[12] ;
input \A_cpu/data_sram_addr[11] ;
input \A_cpu/data_sram_addr[10] ;
input \A_cpu/data_sram_addr[9] ;
input \A_cpu/data_sram_addr[8] ;
input \A_cpu/data_sram_addr[7] ;
input \A_cpu/data_sram_addr[6] ;
input \A_cpu/data_sram_addr[5] ;
input \A_cpu/data_sram_addr[4] ;
input \A_cpu/data_sram_addr[3] ;
input \A_cpu/data_sram_addr[2] ;
input \A_cpu/data_sram_rdata[31] ;
input \A_cpu/data_sram_rdata[30] ;
input \A_cpu/data_sram_rdata[29] ;
input \A_cpu/data_sram_rdata[28] ;
input \A_cpu/data_sram_rdata[27] ;
input \A_cpu/data_sram_rdata[26] ;
input \A_cpu/data_sram_rdata[25] ;
input \A_cpu/data_sram_rdata[24] ;
input \A_cpu/data_sram_rdata[23] ;
input \A_cpu/data_sram_rdata[22] ;
input \A_cpu/data_sram_rdata[21] ;
input \A_cpu/data_sram_rdata[20] ;
input \A_cpu/data_sram_rdata[19] ;
input \A_cpu/data_sram_rdata[18] ;
input \A_cpu/data_sram_rdata[17] ;
input \A_cpu/data_sram_rdata[16] ;
input \A_cpu/data_sram_rdata[15] ;
input \A_cpu/data_sram_rdata[14] ;
input \A_cpu/data_sram_rdata[13] ;
input \A_cpu/data_sram_rdata[12] ;
input \A_cpu/data_sram_rdata[11] ;
input \A_cpu/data_sram_rdata[10] ;
input \A_cpu/data_sram_rdata[9] ;
input \A_cpu/data_sram_rdata[8] ;
input \A_cpu/data_sram_rdata[7] ;
input \A_cpu/data_sram_rdata[6] ;
input \A_cpu/data_sram_rdata[5] ;
input \A_cpu/data_sram_rdata[4] ;
input \A_cpu/data_sram_rdata[3] ;
input \A_cpu/data_sram_rdata[2] ;
input \A_cpu/data_sram_rdata[1] ;
input \A_cpu/data_sram_rdata[0] ;
input \A_cpu/data_sram_wdata[31] ;
input \A_cpu/data_sram_wdata[30] ;
input \A_cpu/data_sram_wdata[29] ;
input \A_cpu/data_sram_wdata[28] ;
input \A_cpu/data_sram_wdata[27] ;
input \A_cpu/data_sram_wdata[26] ;
input \A_cpu/data_sram_wdata[25] ;
input \A_cpu/data_sram_wdata[24] ;
input \A_cpu/data_sram_wdata[23] ;
input \A_cpu/data_sram_wdata[22] ;
input \A_cpu/data_sram_wdata[21] ;
input \A_cpu/data_sram_wdata[20] ;
input \A_cpu/data_sram_wdata[19] ;
input \A_cpu/data_sram_wdata[18] ;
input \A_cpu/data_sram_wdata[17] ;
input \A_cpu/data_sram_wdata[16] ;
input \A_cpu/data_sram_wdata[15] ;
input \A_cpu/data_sram_wdata[14] ;
input \A_cpu/data_sram_wdata[13] ;
input \A_cpu/data_sram_wdata[12] ;
input \A_cpu/data_sram_wdata[11] ;
input \A_cpu/data_sram_wdata[10] ;
input \A_cpu/data_sram_wdata[9] ;
input \A_cpu/data_sram_wdata[8] ;
input \A_cpu/data_sram_wdata[7] ;
input \A_cpu/data_sram_wdata[6] ;
input \A_cpu/data_sram_wdata[5] ;
input \A_cpu/data_sram_wdata[4] ;
input \A_cpu/data_sram_wdata[3] ;
input \A_cpu/data_sram_wdata[2] ;
input \A_cpu/data_sram_wdata[1] ;
input \A_cpu/data_sram_wdata[0] ;
input \A_cpu/A_la132/ifc2fetch_bus[31] ;
input \A_cpu/A_la132/ifc2fetch_bus[30] ;
input \A_cpu/A_la132/ifc2fetch_bus[29] ;
input \A_cpu/A_la132/ifc2fetch_bus[28] ;
input \A_cpu/A_la132/ifc2fetch_bus[27] ;
input \A_cpu/A_la132/ifc2fetch_bus[26] ;
input \A_cpu/A_la132/ifc2fetch_bus[25] ;
input \A_cpu/A_la132/ifc2fetch_bus[24] ;
input \A_cpu/A_la132/ifc2fetch_bus[23] ;
input \A_cpu/A_la132/ifc2fetch_bus[22] ;
input \A_cpu/A_la132/ifc2fetch_bus[21] ;
input \A_cpu/A_la132/ifc2fetch_bus[20] ;
input \A_cpu/A_la132/ifc2fetch_bus[19] ;
input \A_cpu/A_la132/ifc2fetch_bus[18] ;
input \A_cpu/A_la132/ifc2fetch_bus[17] ;
input \A_cpu/A_la132/ifc2fetch_bus[16] ;
input \A_cpu/A_la132/ifc2fetch_bus[15] ;
input \A_cpu/A_la132/ifc2fetch_bus[14] ;
input \A_cpu/A_la132/ifc2fetch_bus[13] ;
input \A_cpu/A_la132/ifc2fetch_bus[12] ;
input \A_cpu/A_la132/ifc2fetch_bus[11] ;
input \A_cpu/A_la132/ifc2fetch_bus[10] ;
input \A_cpu/A_la132/ifc2fetch_bus[9] ;
input \A_cpu/A_la132/ifc2fetch_bus[8] ;
input \A_cpu/A_la132/ifc2fetch_bus[7] ;
input \A_cpu/A_la132/ifc2fetch_bus[6] ;
input \A_cpu/A_la132/ifc2fetch_bus[5] ;
input \A_cpu/A_la132/ifc2fetch_bus[4] ;
input \A_cpu/A_la132/ifc2fetch_bus[3] ;
input \A_cpu/A_la132/ifc2fetch_bus[2] ;
input \A_cpu/A_la132/ifc2fetch_bus[1] ;
input \A_cpu/A_la132/ifc2fetch_bus[0] ;
input \A_cpu/A_axi2apb/state[1] ;
input \A_cpu/A_axi2apb/state[0] ;
input \A_cpu/A_axi2apb/valid ;
input \A_cpu/A_axi2apb/busy ;
input pll_lock;
input clk_ext8m;
input tms_pad_i;
input tck_pad_i;
input tdi_pad_i;
output tdo_pad_o;

wire \A_cpu/A_la132/reset_Z ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_en ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_wr ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[16] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[15] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[14] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[13] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[12] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[11] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[10] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[9] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[8] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[7] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[6] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[5] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[4] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[3] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_addr[2] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[31] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[30] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[29] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[28] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[27] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[26] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[25] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[24] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[23] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[22] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[21] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[20] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[19] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[18] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[17] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[16] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[15] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[14] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[13] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[12] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[11] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[10] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[9] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[8] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[7] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[6] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[5] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[4] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[3] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[2] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[1] ;
wire \A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[0] ;
wire \A_cpu/data_sram_en ;
wire \A_cpu/data_sram_wr ;
wire \A_cpu/data_sram_addr[12] ;
wire \A_cpu/data_sram_addr[11] ;
wire \A_cpu/data_sram_addr[10] ;
wire \A_cpu/data_sram_addr[9] ;
wire \A_cpu/data_sram_addr[8] ;
wire \A_cpu/data_sram_addr[7] ;
wire \A_cpu/data_sram_addr[6] ;
wire \A_cpu/data_sram_addr[5] ;
wire \A_cpu/data_sram_addr[4] ;
wire \A_cpu/data_sram_addr[3] ;
wire \A_cpu/data_sram_addr[2] ;
wire \A_cpu/data_sram_rdata[31] ;
wire \A_cpu/data_sram_rdata[30] ;
wire \A_cpu/data_sram_rdata[29] ;
wire \A_cpu/data_sram_rdata[28] ;
wire \A_cpu/data_sram_rdata[27] ;
wire \A_cpu/data_sram_rdata[26] ;
wire \A_cpu/data_sram_rdata[25] ;
wire \A_cpu/data_sram_rdata[24] ;
wire \A_cpu/data_sram_rdata[23] ;
wire \A_cpu/data_sram_rdata[22] ;
wire \A_cpu/data_sram_rdata[21] ;
wire \A_cpu/data_sram_rdata[20] ;
wire \A_cpu/data_sram_rdata[19] ;
wire \A_cpu/data_sram_rdata[18] ;
wire \A_cpu/data_sram_rdata[17] ;
wire \A_cpu/data_sram_rdata[16] ;
wire \A_cpu/data_sram_rdata[15] ;
wire \A_cpu/data_sram_rdata[14] ;
wire \A_cpu/data_sram_rdata[13] ;
wire \A_cpu/data_sram_rdata[12] ;
wire \A_cpu/data_sram_rdata[11] ;
wire \A_cpu/data_sram_rdata[10] ;
wire \A_cpu/data_sram_rdata[9] ;
wire \A_cpu/data_sram_rdata[8] ;
wire \A_cpu/data_sram_rdata[7] ;
wire \A_cpu/data_sram_rdata[6] ;
wire \A_cpu/data_sram_rdata[5] ;
wire \A_cpu/data_sram_rdata[4] ;
wire \A_cpu/data_sram_rdata[3] ;
wire \A_cpu/data_sram_rdata[2] ;
wire \A_cpu/data_sram_rdata[1] ;
wire \A_cpu/data_sram_rdata[0] ;
wire \A_cpu/data_sram_wdata[31] ;
wire \A_cpu/data_sram_wdata[30] ;
wire \A_cpu/data_sram_wdata[29] ;
wire \A_cpu/data_sram_wdata[28] ;
wire \A_cpu/data_sram_wdata[27] ;
wire \A_cpu/data_sram_wdata[26] ;
wire \A_cpu/data_sram_wdata[25] ;
wire \A_cpu/data_sram_wdata[24] ;
wire \A_cpu/data_sram_wdata[23] ;
wire \A_cpu/data_sram_wdata[22] ;
wire \A_cpu/data_sram_wdata[21] ;
wire \A_cpu/data_sram_wdata[20] ;
wire \A_cpu/data_sram_wdata[19] ;
wire \A_cpu/data_sram_wdata[18] ;
wire \A_cpu/data_sram_wdata[17] ;
wire \A_cpu/data_sram_wdata[16] ;
wire \A_cpu/data_sram_wdata[15] ;
wire \A_cpu/data_sram_wdata[14] ;
wire \A_cpu/data_sram_wdata[13] ;
wire \A_cpu/data_sram_wdata[12] ;
wire \A_cpu/data_sram_wdata[11] ;
wire \A_cpu/data_sram_wdata[10] ;
wire \A_cpu/data_sram_wdata[9] ;
wire \A_cpu/data_sram_wdata[8] ;
wire \A_cpu/data_sram_wdata[7] ;
wire \A_cpu/data_sram_wdata[6] ;
wire \A_cpu/data_sram_wdata[5] ;
wire \A_cpu/data_sram_wdata[4] ;
wire \A_cpu/data_sram_wdata[3] ;
wire \A_cpu/data_sram_wdata[2] ;
wire \A_cpu/data_sram_wdata[1] ;
wire \A_cpu/data_sram_wdata[0] ;
wire \A_cpu/A_la132/ifc2fetch_bus[31] ;
wire \A_cpu/A_la132/ifc2fetch_bus[30] ;
wire \A_cpu/A_la132/ifc2fetch_bus[29] ;
wire \A_cpu/A_la132/ifc2fetch_bus[28] ;
wire \A_cpu/A_la132/ifc2fetch_bus[27] ;
wire \A_cpu/A_la132/ifc2fetch_bus[26] ;
wire \A_cpu/A_la132/ifc2fetch_bus[25] ;
wire \A_cpu/A_la132/ifc2fetch_bus[24] ;
wire \A_cpu/A_la132/ifc2fetch_bus[23] ;
wire \A_cpu/A_la132/ifc2fetch_bus[22] ;
wire \A_cpu/A_la132/ifc2fetch_bus[21] ;
wire \A_cpu/A_la132/ifc2fetch_bus[20] ;
wire \A_cpu/A_la132/ifc2fetch_bus[19] ;
wire \A_cpu/A_la132/ifc2fetch_bus[18] ;
wire \A_cpu/A_la132/ifc2fetch_bus[17] ;
wire \A_cpu/A_la132/ifc2fetch_bus[16] ;
wire \A_cpu/A_la132/ifc2fetch_bus[15] ;
wire \A_cpu/A_la132/ifc2fetch_bus[14] ;
wire \A_cpu/A_la132/ifc2fetch_bus[13] ;
wire \A_cpu/A_la132/ifc2fetch_bus[12] ;
wire \A_cpu/A_la132/ifc2fetch_bus[11] ;
wire \A_cpu/A_la132/ifc2fetch_bus[10] ;
wire \A_cpu/A_la132/ifc2fetch_bus[9] ;
wire \A_cpu/A_la132/ifc2fetch_bus[8] ;
wire \A_cpu/A_la132/ifc2fetch_bus[7] ;
wire \A_cpu/A_la132/ifc2fetch_bus[6] ;
wire \A_cpu/A_la132/ifc2fetch_bus[5] ;
wire \A_cpu/A_la132/ifc2fetch_bus[4] ;
wire \A_cpu/A_la132/ifc2fetch_bus[3] ;
wire \A_cpu/A_la132/ifc2fetch_bus[2] ;
wire \A_cpu/A_la132/ifc2fetch_bus[1] ;
wire \A_cpu/A_la132/ifc2fetch_bus[0] ;
wire \A_cpu/A_axi2apb/state[1] ;
wire \A_cpu/A_axi2apb/state[0] ;
wire \A_cpu/A_axi2apb/valid ;
wire \A_cpu/A_axi2apb/busy ;
wire pll_lock;
wire clk_ext8m;
wire tms_pad_i;
wire tck_pad_i;
wire tdi_pad_i;
wire tdo_pad_o;
wire tms_i_c;
wire tck_i_c;
wire tdi_i_c;
wire tdo_o_c;
wire [9:0] control0;
wire gao_jtag_tck;
wire gao_jtag_reset;
wire run_test_idle_er1;
wire run_test_idle_er2;
wire shift_dr_capture_dr;
wire update_dr;
wire pause_dr;
wire enable_er1;
wire enable_er2;
wire gao_jtag_tdi;
wire tdo_er1;

IBUF tms_ibuf (
    .I(tms_pad_i),
    .O(tms_i_c)
);

IBUF tck_ibuf (
    .I(tck_pad_i),
    .O(tck_i_c)
);

IBUF tdi_ibuf (
    .I(tdi_pad_i),
    .O(tdi_i_c)
);

OBUF tdo_obuf (
    .I(tdo_o_c),
    .O(tdo_pad_o)
);

GW_JTAG  u_gw_jtag(
    .tms_pad_i(tms_i_c),
    .tck_pad_i(tck_i_c),
    .tdi_pad_i(tdi_i_c),
    .tdo_pad_o(tdo_o_c),
    .tck_o(gao_jtag_tck),
    .test_logic_reset_o(gao_jtag_reset),
    .run_test_idle_er1_o(run_test_idle_er1),
    .run_test_idle_er2_o(run_test_idle_er2),
    .shift_dr_capture_dr_o(shift_dr_capture_dr),
    .update_dr_o(update_dr),
    .pause_dr_o(pause_dr),
    .enable_er1_o(enable_er1),
    .enable_er2_o(enable_er2),
    .tdi_o(gao_jtag_tdi),
    .tdo_er1_i(tdo_er1),
    .tdo_er2_i(1'b0)
);

gw_con_top  u_icon_top(
    .tck_i(gao_jtag_tck),
    .tdi_i(gao_jtag_tdi),
    .tdo_o(tdo_er1),
    .rst_i(gao_jtag_reset),
    .control0(control0[9:0]),
    .enable_i(enable_er1),
    .shift_dr_capture_dr_i(shift_dr_capture_dr),
    .update_dr_i(update_dr)
);

ao_top_0  u_la0_top(
    .control(control0[9:0]),
    .trig0_i({\A_cpu/A_flash/flash_128k_inst/inst_sram_en ,pll_lock}),
    .data_i({\A_cpu/A_la132/reset_Z ,\A_cpu/A_flash/flash_128k_inst/inst_sram_en ,\A_cpu/A_flash/flash_128k_inst/inst_sram_wr ,\A_cpu/A_flash/flash_128k_inst/inst_sram_addr[16] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_addr[15] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_addr[14] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_addr[13] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_addr[12] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_addr[11] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_addr[10] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_addr[9] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_addr[8] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_addr[7] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_addr[6] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_addr[5] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_addr[4] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_addr[3] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_addr[2] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[31] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[30] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[29] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[28] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[27] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[26] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[25] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[24] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[23] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[22] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[21] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[20] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[19] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[18] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[17] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[16] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[15] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[14] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[13] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[12] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[11] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[10] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[9] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[8] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[7] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[6] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[5] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[4] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[3] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[2] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[1] ,\A_cpu/A_flash/flash_128k_inst/inst_sram_rdata[0] ,\A_cpu/data_sram_en ,\A_cpu/data_sram_wr ,\A_cpu/data_sram_addr[12] ,\A_cpu/data_sram_addr[11] ,\A_cpu/data_sram_addr[10] ,\A_cpu/data_sram_addr[9] ,\A_cpu/data_sram_addr[8] ,\A_cpu/data_sram_addr[7] ,\A_cpu/data_sram_addr[6] ,\A_cpu/data_sram_addr[5] ,\A_cpu/data_sram_addr[4] ,\A_cpu/data_sram_addr[3] ,\A_cpu/data_sram_addr[2] ,\A_cpu/data_sram_rdata[31] ,\A_cpu/data_sram_rdata[30] ,\A_cpu/data_sram_rdata[29] ,\A_cpu/data_sram_rdata[28] ,\A_cpu/data_sram_rdata[27] ,\A_cpu/data_sram_rdata[26] ,\A_cpu/data_sram_rdata[25] ,\A_cpu/data_sram_rdata[24] ,\A_cpu/data_sram_rdata[23] ,\A_cpu/data_sram_rdata[22] ,\A_cpu/data_sram_rdata[21] ,\A_cpu/data_sram_rdata[20] ,\A_cpu/data_sram_rdata[19] ,\A_cpu/data_sram_rdata[18] ,\A_cpu/data_sram_rdata[17] ,\A_cpu/data_sram_rdata[16] ,\A_cpu/data_sram_rdata[15] ,\A_cpu/data_sram_rdata[14] ,\A_cpu/data_sram_rdata[13] ,\A_cpu/data_sram_rdata[12] ,\A_cpu/data_sram_rdata[11] ,\A_cpu/data_sram_rdata[10] ,\A_cpu/data_sram_rdata[9] ,\A_cpu/data_sram_rdata[8] ,\A_cpu/data_sram_rdata[7] ,\A_cpu/data_sram_rdata[6] ,\A_cpu/data_sram_rdata[5] ,\A_cpu/data_sram_rdata[4] ,\A_cpu/data_sram_rdata[3] ,\A_cpu/data_sram_rdata[2] ,\A_cpu/data_sram_rdata[1] ,\A_cpu/data_sram_rdata[0] ,\A_cpu/data_sram_wdata[31] ,\A_cpu/data_sram_wdata[30] ,\A_cpu/data_sram_wdata[29] ,\A_cpu/data_sram_wdata[28] ,\A_cpu/data_sram_wdata[27] ,\A_cpu/data_sram_wdata[26] ,\A_cpu/data_sram_wdata[25] ,\A_cpu/data_sram_wdata[24] ,\A_cpu/data_sram_wdata[23] ,\A_cpu/data_sram_wdata[22] ,\A_cpu/data_sram_wdata[21] ,\A_cpu/data_sram_wdata[20] ,\A_cpu/data_sram_wdata[19] ,\A_cpu/data_sram_wdata[18] ,\A_cpu/data_sram_wdata[17] ,\A_cpu/data_sram_wdata[16] ,\A_cpu/data_sram_wdata[15] ,\A_cpu/data_sram_wdata[14] ,\A_cpu/data_sram_wdata[13] ,\A_cpu/data_sram_wdata[12] ,\A_cpu/data_sram_wdata[11] ,\A_cpu/data_sram_wdata[10] ,\A_cpu/data_sram_wdata[9] ,\A_cpu/data_sram_wdata[8] ,\A_cpu/data_sram_wdata[7] ,\A_cpu/data_sram_wdata[6] ,\A_cpu/data_sram_wdata[5] ,\A_cpu/data_sram_wdata[4] ,\A_cpu/data_sram_wdata[3] ,\A_cpu/data_sram_wdata[2] ,\A_cpu/data_sram_wdata[1] ,\A_cpu/data_sram_wdata[0] ,\A_cpu/A_la132/ifc2fetch_bus[31] ,\A_cpu/A_la132/ifc2fetch_bus[30] ,\A_cpu/A_la132/ifc2fetch_bus[29] ,\A_cpu/A_la132/ifc2fetch_bus[28] ,\A_cpu/A_la132/ifc2fetch_bus[27] ,\A_cpu/A_la132/ifc2fetch_bus[26] ,\A_cpu/A_la132/ifc2fetch_bus[25] ,\A_cpu/A_la132/ifc2fetch_bus[24] ,\A_cpu/A_la132/ifc2fetch_bus[23] ,\A_cpu/A_la132/ifc2fetch_bus[22] ,\A_cpu/A_la132/ifc2fetch_bus[21] ,\A_cpu/A_la132/ifc2fetch_bus[20] ,\A_cpu/A_la132/ifc2fetch_bus[19] ,\A_cpu/A_la132/ifc2fetch_bus[18] ,\A_cpu/A_la132/ifc2fetch_bus[17] ,\A_cpu/A_la132/ifc2fetch_bus[16] ,\A_cpu/A_la132/ifc2fetch_bus[15] ,\A_cpu/A_la132/ifc2fetch_bus[14] ,\A_cpu/A_la132/ifc2fetch_bus[13] ,\A_cpu/A_la132/ifc2fetch_bus[12] ,\A_cpu/A_la132/ifc2fetch_bus[11] ,\A_cpu/A_la132/ifc2fetch_bus[10] ,\A_cpu/A_la132/ifc2fetch_bus[9] ,\A_cpu/A_la132/ifc2fetch_bus[8] ,\A_cpu/A_la132/ifc2fetch_bus[7] ,\A_cpu/A_la132/ifc2fetch_bus[6] ,\A_cpu/A_la132/ifc2fetch_bus[5] ,\A_cpu/A_la132/ifc2fetch_bus[4] ,\A_cpu/A_la132/ifc2fetch_bus[3] ,\A_cpu/A_la132/ifc2fetch_bus[2] ,\A_cpu/A_la132/ifc2fetch_bus[1] ,\A_cpu/A_la132/ifc2fetch_bus[0] ,\A_cpu/A_axi2apb/state[1] ,\A_cpu/A_axi2apb/state[0] ,\A_cpu/A_axi2apb/valid ,\A_cpu/A_axi2apb/busy }),
    .clk_i(clk_ext8m)
);

endmodule
