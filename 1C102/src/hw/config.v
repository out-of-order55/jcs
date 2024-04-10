// timescale
`timescale 1ns/1ps

`define FPGA

/*****************
*   AXI interface
******************/

`define AXI_SLV_MUX_2            // SLV_MUX_2-6   Optional 2-6 AXI buses
// `define AXI_SLV_MUX_3
//`define AXI_SLV_MUX_4
//`define AXI_SLV_MUX_5
//`define AXI_SLV_MUX_6



//AXI0   connect APBbrige 
//AXI0   this address is the remaining address on other ways

//AXI1
`define AXI_SLV1_ADDR_BASE   32'hffffffff     //AXI1 base address   
`define AXI_SLV1_ADDR_LEN    32'h00000000     //AXI1 length

//AXI2
`define AXI_SLV2_ADDR_BASE   32'hffffffff     //AXI2 base address   
`define AXI_SLV2_ADDR_LEN    32'h00000000     //AXI2 length
//AXI3
`define AXI_SLV3_ADDR_BASE   32'hffffffff     //AXI3 base address   
`define AXI_SLV3_ADDR_LEN    32'h00000000     //AXI3 length
//AXI4
`define AXI_SLV4_ADDR_BASE   32'hffffffff     //AXI4 base address   
`define AXI_SLV4_ADDR_LEN    32'h00000000     //AXI4 length
//AXI5
`define AXI_SLV5_ADDR_BASE   32'hffffffff     //AXI5 base address   
`define AXI_SLV5_ADDR_LEN    32'h00000000     //AXI5 length

`define Lawaddr 32 
`define Lawlen 4
`define Lawsize 3
`define Lawburst 2
`define Lawlock 2
`define Lawcache 4
`define Lawprot 3
`define Lwdata 32
`define Lwstrb 4
`define Lwlast 1
`define Lbresp 2
`define Laraddr 32
`define Larlen 4
`define Larsize 3
`define Larburst 2
`define Larlock 2
`define Larcache 4
`define Larprot 3
`define Lrdata 32
`define Lrresp 2
`define Lrlast 1
`define LID 4


/*****************
*   APB interface      9-way APB
******************/

`define ADDR_APB 32
`define DATA_APB 32

//APB0    gpio
`define APB_SLV0_ADDR_BASE   32'hbfeb0000     //APB0 base address    
`define APB_SLV0_ADDR_LEN    32'h0000ffff     //APB0 length
//APB1    pwm
`define APB_SLV1_ADDR_BASE   32'hbfec0000    //APB1 base address    
`define APB_SLV1_ADDR_LEN    32'h0000ffff     //APB1 length
//APB2    hpet
`define APB_SLV2_ADDR_BASE   32'hbfed0000     //APB2 base address    
`define APB_SLV2_ADDR_LEN    32'h0000ffff     //APB3 length
//APB3    confreg
`define APB_SLV3_ADDR_BASE   32'hbfea0000     //APB3 base address    
`define APB_SLV3_ADDR_LEN    32'h0000ffff     //APB3 length
//APB4    uart
`define APB_SLV4_ADDR_BASE   32'hbfe88000     //APB4 base address    
`define APB_SLV4_ADDR_LEN    32'h0000ffff     //APB4 length
//APB5    i2c
`define APB_SLV5_ADDR_BASE   32'hbfe90000     //APB5 base address    
`define APB_SLV5_ADDR_LEN    32'h0000ffff     //APB5 length
//APB6    spi
`define APB_SLV6_ADDR_BASE   32'hbfe70000     //APB6 base address     
`define APB_SLV6_ADDR_LEN    32'h0000ffff     //APB6 length
//APB7
`define APB_SLV7_ADDR_BASE   32'hffffffff     //APB7 base address   
`define APB_SLV7_ADDR_LEN    32'hffffffff     //APB7 length
//APB8
`define APB_SLV8_ADDR_BASE   32'hffffffff     //APB8 base address   
`define APB_SLV8_ADDR_LEN    32'hffffffff     //APB8 length



// FLASH controller
`define ERASE_PAGE_CMD   4'b1010
`define PROGR_PAGE_CMD   4'b1110
`define CLEAR_HVPL_CMD   4'b0100
`define UPDATE_KEY_CMD   4'b1111
`define UPDATE_BOUND_CMD 4'b1001
`define VERIF            4'b0001
`define TEST_KEY         4'b0010
`define INT_CLEAR        4'b0011
`define SLEEP            4'b1100

`define WAIT0 0
`define SEQ1  1
`define WAIT1 2
`define SEQ2  3
`define WAIT2 4
`define SEQ3  5
`define WAIT3 6
`define SEQ0  7

`define TS2P 1
`define PE   2
`define TPS3 3

`define FM_BASE_ADDR 32'h1f000000
`define FM_MASK_ADDR 32'hff3c0000  // for 128K

`define CMD_ADDR     32'h1fe60000
`define CADDR_H      32'h1fe60004
`define CADDR_L      32'h1fe60008
`define VERIF_DATA   32'h1fe60010
`define STATUS_ADDR  32'h1fe60014
`define PE_TIME_MODE 32'h1fe60018

`define TEST_KEY_H  32'h1fe6001c
`define TEST_KEY_L  32'h1fe60020
`define WRITE_KEY   32'h1fe60024
`define TRIMMING1   32'h1fe60028
`define TRIMMING2   32'h1fe6002c
`define TRIMMING3   32'h1fe60030

`define BOUND       32'h1fe60034
`define CFG_DATA    32'h1fe60038

// HPET
`define HPET_CFG    4'h0
`define HPET_CNT    4'h4
`define HPET_CMP    4'h8
`define HPET_STP    4'hc

// confreg 
`define INT_EN      20'ha0000
`define INT_EDGE    20'ha0001
`define INT_POL     20'ha0002
`define INT_CLR     20'ha0003
`define INT_SET     20'ha0004
`define INT_OUT     20'ha0005
`define SRPROT      20'ha0006

`define PKG_SEL_SPIB2 32'h55000000
`define PKG_SEL_SPIB3 32'h00000001

// `define PKG_SEL_IO2ND 32'hffffffff
// `define PKG_SEL_GPIO  32'h0

// I2C
`define I2C_CMD_NOP   4'b0000
`define I2C_CMD_START 4'b0001
`define I2C_CMD_STOP  4'b0010
`define I2C_CMD_WRITE 4'b0100
`define I2C_CMD_READ  4'b1000


