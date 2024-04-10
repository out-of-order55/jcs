/*
 * Soroll.h
 *
 *  Created on: 2023年8月10日
 *      Author: zxy
 */

#ifndef LIB_TOOLS_SOROLL_H_
#define LIB_TOOLS_SOROLL_H_
#include "World_1c101.h"

typedef enum RollDir_E
{
	ROLLDIR_UP  = 0 ,
	ROLLDIR_DOWN = 1
}RollDir ;
typedef enum RollRst_E
{
	ROLL_RST_SUCCESS  = 0 ,
	ROLL_RST_UPPER_LIMIT,
	ROLL_RST_LOWER_LIMIT,
}RollRst ;

RollDir Soroll(RollDir Dir,uint8 *dat,uint32 SYS_VOLUME_MAX,uint32 min) ;


#endif /* LIB_TOOLS_SOROLL_H_ */
