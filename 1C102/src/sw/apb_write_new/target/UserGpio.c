#include "UserGpio.h"
#include "ls1x.h"



//#define	 UART0_RX_PIN 				GPIO_Pin_14
//#define	 UART0_TX_PIN 				GPIO_Pin_15
//#define	 UART0_PORT 				GPIOA
//#define	 UART0_AFIO 				AFIOA
//#define	 UART0_PIN_FUNC 			GPIO_FUNC_MAIN
//
//#define	 SPI_CLK                         	GPIO_Pin_4
//#define	 SPI_MOSI                               GPIO_Pin_5
//#define	 SPI_MISO                               GPIO_Pin_6
//#define	 SPI_CSB                                GPIO_Pin_7
//#define	 SPI_PORT                               GPIOB
//#define	 SPI_AFIO                               AFIOB
//#define	 SPI_PIN_FUNC 				GPIO_FUNC_MAIN

void GPIOInit(void)
{
  AFIO_RemapConfig(AFIOA, GPIO_Pin_0 | GPIO_Pin_1 | \
		          GPIO_Pin_2 | GPIO_Pin_3 | \
		          GPIO_Pin_4 | GPIO_Pin_5 | \
		          GPIO_Pin_6 | GPIO_Pin_7 | \
		          GPIO_Pin_8 | GPIO_Pin_9 | \
		          GPIO_Pin_10 | GPIO_Pin_11 | \
		          GPIO_Pin_12 | GPIO_Pin_13 | \
			  GPIO_Pin_14 | GPIO_Pin_15, GPIO_FUNC_MAIN);

  AFIO_RemapConfig(AFIOB, GPIO_Pin_0 | GPIO_Pin_1 | \
		          GPIO_Pin_2 | GPIO_Pin_3 | \
		          GPIO_Pin_4 | GPIO_Pin_5 | \
		          GPIO_Pin_6 | GPIO_Pin_7 | \
		          GPIO_Pin_8 | GPIO_Pin_9 | \
		          GPIO_Pin_10 | GPIO_Pin_11 | \
		          GPIO_Pin_12 | GPIO_Pin_13 | \
			  GPIO_Pin_14 | GPIO_Pin_15, GPIO_FUNC_MAIN);

  AFIO_RemapConfig(AFIOC, GPIO_Pin_0 | GPIO_Pin_1 | \
		          GPIO_Pin_2 | GPIO_Pin_3 | \
		          GPIO_Pin_4 | GPIO_Pin_5 | \
		          GPIO_Pin_8 | GPIO_Pin_9 | \
		          GPIO_Pin_10 | GPIO_Pin_11 | \
		          GPIO_Pin_12 | GPIO_Pin_13 | \
			  GPIO_Pin_14 | GPIO_Pin_15, GPIO_FUNC_MAIN);

  AFIO_RemapConfig(AFIOC, GPIO_Pin_6 | GPIO_Pin_7, GPIO_FUNC_FIRST);
                  
  AFIO_RemapConfig(AFIOD, GPIO_Pin_0 | GPIO_Pin_1 | \
		          GPIO_Pin_2 | GPIO_Pin_3 | \
		          GPIO_Pin_4 | GPIO_Pin_5 | \
		          GPIO_Pin_6 | GPIO_Pin_7 | \
		          GPIO_Pin_8 | GPIO_Pin_9 | \
		          GPIO_Pin_10 | GPIO_Pin_11 | \
		          GPIO_Pin_12 | GPIO_Pin_13 | \
			  GPIO_Pin_14 | GPIO_Pin_15, GPIO_FUNC_MAIN);
}
