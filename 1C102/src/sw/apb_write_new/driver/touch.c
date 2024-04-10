/*
 * touch.c
 *
 *  Created on: 2023年6月5日
 *      Author: j
 */

#include "ls1c102_touch.h"
#include "Config.h"
#include "ls1x.h"
#include "test.h"


void ls1c102_touch_init(INT8U down_th)
{
    Touch_CountBaseInitTypeDef Touch_CountBaseInitStruct;
    Touch_PerformInitTypeDef   Touch_PerformInitStruct;
    Touch_ControlConfigTypeDef Touch_ControlConfigStruct;

    Touch_CountBaseInitStruct.TOUCH_up_th   = 80;
    Touch_CountBaseInitStruct.TOUCH_bas_th  = 0x10;
    Touch_CountBaseInitStruct.TOUCH_cnt_neg = 1;
    Touch_CountBaseInitStruct.TOUCH_cnt_prd = 0x3;
    Touch_CountBaseInitStruct.TOUCH_rsel    = 0x3;
    Touch_CountBaseInit(&Touch_CountBaseInitStruct);

    Touch_PerformInitStruct.TOUCH_dbc_prd = 0x3;
    Touch_PerformInitStruct.TOUCH_act_stb = 0x0;
    Touch_PerformInitStruct.TOUCH_stb_prd = 0x8;
    Touch_PerformInitStruct.TOUCH_act_prd = 0x8;
    Touch_PerformInitStruct.TOUCH_act_num = 0xff;
    Touch_PerformInit(&Touch_PerformInitStruct);

    Touch_ControlConfigStruct.TOUCH_chn_en    = 0xfff;
    Touch_ControlConfigStruct.TOUCH_dbc_en    = 0x1;
    Touch_ControlConfigStruct.TOUCH_dbc_num   = 0x3;
    Touch_ControlConfigStruct.TOUCH_eos_ov    = 0x0;
    Touch_ControlConfigStruct.TOUCH_flt_level = 0x3;
    Touch_ControlConfigStruct.TOUCH_int_en    = 0x1;
    Touch_ControlConfigStruct.TOUCH_poll_en   = 0x0;
    Touch_ControlConfigStruct.TOUCH_scan_en   = 0x0;
    Touch_ControlConfig(&Touch_ControlConfigStruct);

    TOUCH_EnableSingleScan();
    while(TS_CTRL & 0x1);  //wait scan end
    TOUCH_SetAllChnAttr(down_th);

    TOUCH_Cmd(ENABLE);
}


void ls102_touch_test()
{
    printf("\n ---- ls102_touch_test ----\n");

	delay_s(1);
	ls1c102_touch_init(100);

	Printf_CountVal();

	TOUCH_EnablePollScan();
    printf("TOUCH_EnablePollScan...\n");
    int sts = PMU_CMDSTS;
    printf("sts:%d\n",(sts>>9) & 0x1);

    touch_reg_show();
    touch_value_show();

    delay_s(1);
	while(1){
		delay_ms(200);
		Printf_CountVal();
//	    printf("TS_STAT: 0x%x\n",TS_STAT & 0x7);

		WDG_DogFeed();
	}
}


void ls102_touch_basval_init()
{
    INT32S KeyChannel,basvalVal[CHANNEL_NUM];
    INT32S CountVal[CHANNEL_NUM]={0};
    int i;
    for(i=0;i<4;i++){
        for(KeyChannel=0; KeyChannel<CHANNEL_NUM; KeyChannel++){
            CountVal[KeyChannel] += TOUCH_GetCountValue(KeyChannel);
        }
    }
    printf("basvalVal:");
    for(KeyChannel=0; KeyChannel<CHANNEL_NUM; KeyChannel++){
    	basvalVal[KeyChannel] = CountVal[KeyChannel] >> 2;
    	TOUCH_SetBaseVal(KeyChannel,basvalVal[KeyChannel]);
        printf("%d ",basvalVal[KeyChannel]);
    }
    printf("\n");

}
