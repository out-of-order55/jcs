#include "ls1x_wdg.h"
#include "ls1x.h"


void WDG_SetWatchDog(uint32_t time)
{
    PMU->WDT_FEED = 0xa55a55aa;
    PMU->WDT_CFG = (((~time)<<16) | time);
}

void WDG_DogFeed(void)
{
    PMU->WDT_FEED = 0xa55a55aa;
}


void WdgInit(void)
{
    WDG_SetWatchDog(0x80007fff);
}
