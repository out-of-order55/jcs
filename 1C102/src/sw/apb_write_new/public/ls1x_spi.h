#ifndef     __LS1X_SPI__H
#define     __LS1X_SPI__H

#include "test.h"

#define SPI_TXEMPTY (SPI->SPSR & 0x04)
#define SPI_RXEMPTY (SPI->SPSR & 0x01)
#define SPI_TXFULL  (SPI->SPSR & 0x08)
#define SPI_RXFULL  (SPI->SPSR & 0x02)


#define SPI_INT_ENABLE      (SPI->SPCR |=0x80)          //SPI 控制器使能
#define SPI_INT_DISABLE     (SPI->SPCR &=~(0x80))       //SPI 控制器停止



#define SPI_ENABLE      (SPI->SPCR |=0x40)          //SPI 控制器使能
#define SPI_DISABLE     (SPI->SPCR &=~(0x40))       //SPI 控制器停止

#define SPI_MODE_MASTER     (SPI->SPCR |=0x10)
#define SPI_MODE_SLAVE      (SPI->SPCR &=~(0x10))

#define SPI_CPOL_HIGH     (SPI->SPCR |=0x08)
#define SPI_CPOL_LOW      (SPI->SPCR &=~(0x08))

#define SPI_CPHA_SAME     (SPI->SPCR |=0x04)
#define SPI_CPHA_REV      (SPI->SPCR &=~(0x04))

#define SPI_CLR_SPSR    (SPI->SPSR = 0xC0)          //SPI 重置SPI状态寄存器


#define SPI_MODE_COMPATIBILIY     	(SPI->SPER |=0x04)
#define SPI_MODE_STAND      		(SPI->SPER &=~(0x04))

#define SPI_TRANST_1BYTE 			(SPI->SPER &=0x3F)
#define SPI_TRANST_2BYTE 			(SPI->SPER |=(1<<6))
#define SPI_TRANST_3BYTE 			(SPI->SPER |=(2<<6))
#define SPI_TRANST_4BYTE			(SPI->SPER |=(3<<6))

// #define SPI_ENABLE_CS(n)     {SPI->SOFTCS |=(1<<n); SPI->SOFTCS &=~(1<<(n+4)); }
// #define SPI_DISABLE_CS(n)    {SPI->SOFTCS &=~(1<<n); SPI->SOFTCS |=(1<<(n+4)) }
#define SPI_ENABLE_CS(n)     	( SPI->SOFTCS |=(1<<n) )
#define SPI_DISABLE_CS(n)    	( SPI->SOFTCS &=~(1<<n) )
#define SPI_LOW_CS(n)     		(SPI->SOFTCS &=~(1<<(n+4)))
#define SPI_HIGH_CS(n)    		(SPI->SOFTCS |=(1<<(n+4)) )



void Spi_Init(uint8_t spr);

void Spi_Write_Read_1to4(uint8_t* buf, int n);

void Spi_Write_Read_N(uint8_t* buf, int n);

void Spi_Cs_Down(void);

void Spi_Cs_Up(void);

void Spi_Send(uint8_t* buf, int n);



/************SPI FLASH*********************/

void Spiflash_Wait_Wip_Zero(void);

void Spiflash_Wren(void);

void Spiflash_Wrsr(uint8_t st);

uint8_t Spiflash_Rdsr2(void);

uint8_t Spiflash_Rdsr3(void);

uint16_t Spiflash_Rdid(void);

void Spiflash_Sector_Erase(uint32_t addr);

void Spiflash_Block64k_Erase(uint32_t addr);

void Spiflash_Page_Program(uint32_t addr, uint8_t* data_256, int n);

void Spiflash_Read_Bytes(uint32_t addr, uint8_t* data, int n);


#endif




