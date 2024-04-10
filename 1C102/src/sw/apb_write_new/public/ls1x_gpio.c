#include "ls1x_gpio.h"
#include "ls1x.h"
#include "test.h"
#include "Config.h"

void AFIO_RemapConfig(AFIO_TypeDef* AFIOx, uint16_t GPIO_Pin, GPIOFunc_TypeDef GPIO_Func)
{
	uint32_t currentpinpos = 0x00;
	uint32_t tmpreg = 0x00, pinmask = 0x00;

	tmpreg = AFIOx->IOSEL;
	for (uint8_t i=0; i < 16; i++)
	{
	    if ((GPIO_Pin & (0x01 << i)) != 0x0)
	    {
	    	currentpinpos = i << 1;
	    	pinmask =((uint32_t)0x03 << currentpinpos);
	    	tmpreg &= ~pinmask;
	    	tmpreg |= (GPIO_Func << currentpinpos);
	    }
	}

	AFIOx->IOSEL = tmpreg;
}


