/*
 * Soroll.c
 *
 *  Created on: 2023年8月10日
 *      Author: zxy
 */
#include"Soroll.h"

RollDir Soroll(RollDir Dir,uint8 *dat,uint32 max,uint32 min)
{

	if(Dir == ROLLDIR_UP)
	{
		(*dat)++ ;
		if((*dat)== max)
		{
			return ROLL_RST_UPPER_LIMIT ;
		}
	}
	else
	{
		(*dat)-- ;
		if((*dat) == min)
		{
			return ROLL_RST_LOWER_LIMIT ;
		}
	}
	return ROLL_RST_SUCCESS ;
}

