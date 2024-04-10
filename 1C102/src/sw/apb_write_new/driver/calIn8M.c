/*
 * calIn8M.c
 *
 *  Created on: 2023年9月5日
 *      Author: j
 */

#include "calIn8M.h"

#include "ls1x.h"
#include "Buffer.h"
#include "ls1x_latimer.h"
#include "ls1x_gpio.h"
#include "Config.h"

#define CLOCK_EXT32k_ENABLE	0x02

void check_clock(unsigned char enable){
	unsigned int x;
    //如果32k时钟初始化时没有配置成功，则继续配置32时钟
    if((enable & CLOCK_EXT32k_ENABLE) != 0
    		&& ((PMU_CMDSTS&(1<<28)) == 0||(PMU_CMDSTS&(1<<29)) == 1)){
    	PMU_CHIPCTRL &= ~(1<<5);
    	for(x = 2; x > 0; x--);  // delay 30us
    	PMU_CHIPCTRL |= (1<<5);
    	for(x = 2; x > 0; x--);  // delay 30us
    }
//    //如果8M时钟初始化时没有配置成功，则继续配置8M时钟
//    if((enable & CLOCK_EXT8M_ENABLE) != 0
//    	&& ((PMU_CmdSts&(1<<30)) == 0||(PMU_CmdSts&(1<<31)) == 1)){
//    	PMU_ChipCtrl &= ~(1<<7);
//    	for(x = 2; x > 0; x--);  // delay 30us
//    	PMU_ChipCtrl |= (1<<7);
//    	for(x = 2; x > 0; x--);  // delay 30us
//    }
}

void buad_test()
{
	int b = 9600;
	while(1){
		WDG_DogFeed();
		Uart0_init_buad(b);
		delay_ms(50);
		printf("\nbaud test...baud = %d\n",b);
		b += 10;
		if(b==155200){
			b = 3600;
		}
	}
}


void test_8m_out()
{
//	gpio_pin_remap(GPIO_PIN_2,GPIO_FUNC_MAIN);
//	gpio_pin_remap(GPIO_PIN_3,GPIO_FUNC_MAIN);
	AFIO_RemapConfig(AFIOA, GPIO_Pin_2 | GPIO_Pin_3, GPIO_FUNC_MAIN);

	PMU_Pulse0 = 0x10001;
	PMU_Pulse1 = 0x10001;
	PMU_Pulse0 |= 1<<17;
	PMU_Pulse1 |= 1<<17;
}


int cal_in8m_touch()
{
	PMU_CHIPCTRL = 0x0000e020;
	check_clock(CLOCK_EXT32k_ENABLE);

	int osc_prd = 4;
	int channelNum = 12;
	TS_OSCTH = (0x00f | (osc_prd<<8));
	TS_CTRL = 0xfff0009;
	while(TS_CTRL & 0x1);
	int i,j,tmp,cnt;
	int max=1;
	int min=4000;
	int cntAll = 0;
	int calAddCount = 20;
	int errCount=0;
//	printf("TS_CNTRES:\n");

	for(j=0;j<calAddCount;j++){
		cnt = 0;
		max=1;
		min=4000;
		for(i=0;i<channelNum;i++){
			tmp = TS_CNTRES(i);

			if(max<tmp)
				max= tmp;
			if(tmp < min)
				min=tmp;
//			printf("%d ",tmp);

			cnt+=tmp;
		}
//		printf("----avg = %d\n",cnt/channelNum);

		if(max-min>50){
//			printf("8M ERROR \n",cnt);
//			calAddCount--;
			errCount++;
		}
		else{
			cnt = (cnt/channelNum/osc_prd)*32768/1000;
			cntAll += cnt;
//			printf("--- 8M= %d k\n",cnt);

		}

		delay_ms(1);
	}
//	printf("cntAll/%d:%d \n",calAddCount,cntAll/calAddCount);
	PMU_CHIPCTRL &= ~(1<<3);	//关闭测试模式


	return (cntAll/(calAddCount-errCount));
}


int test_cal_in8m_touch_scan()
{

	printf("\n\n---cal_in8m_touch_test---\n");
	int f = cal_in8m_touch();
	f = f * 1000;
	printf("------------- cal_in8m_touch : f = %d---\n",f);

//	101 read
//	PMU_CHIPCTRL = 0x0000e020;
//	printf("PMU_ChipCtrl:0x%x\n",PMU_CHIPCTRL);

//	test_8m_out();

	check_clock(CLOCK_EXT32k_ENABLE);



while(1){

#if 0	//无过滤
	TS_OSCTH = 0x80f;
	TS_CTRL = 0xfff0009;
	while(TS_CTRL & 0x1);
	int i,tmp,cnt;
	cnt = 0;
	printf("TS_CNTRES:\n");
	for(i=0;i<12;i++){
		tmp = TS_CNTRES(i);
		printf("%d ",tmp);
		cnt+=tmp;
	}
	printf("----avg = %d\n",cnt/12);

	cnt = (cnt/12/8)*32768/1000;

	printf("8M= %d k\n",cnt);
#endif

#if 1//过滤
	TS_OSCTH = 0x80f;
	TS_CTRL = 0xfff0009;
	while(TS_CTRL & 0x1);
	int i,tmp,cnt;
	int max=1;
	int min=4000;
	cnt = 0;
	printf("TS_CNTRES:\n");
	for(i=0;i<12;i++){
		tmp = TS_CNTRES(i);

		if(max<tmp)
			max= tmp;
		if(tmp < min)
			min=tmp;

		printf("%d ",tmp);
		cnt+=tmp;
	}
	printf("----avg = %d\n",cnt/12);

	if(max-min>50)
		printf("8M ERROR \n",cnt);
	else{
		cnt = (cnt/12/8)*32768/1000;
		printf("--- 8M= %d k\n",cnt);
	}
#endif

	WDG_DogFeed();
	delay_ms(500);
}


//	return cnt;
	return 0;

}
