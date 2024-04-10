/*
 *
 *  Created on: 2021年1月21日
 *      Author: loongson
 */

#ifndef _BUFFER_H_
#define _BUFFER_H_

#include "test.h"
//默认设置数据
//#define RESULT_OK      0
//#define RESULT_ERROR   1
//#define RESULT_TRUE           1
//#define RESULT_FALSE          0
#define RESULT_SMALLER         -1
#define RESULT_EQUAL            0
#define RESULT_BIGGER           1



#define NO_INIT volatile

#define true 1
#define false 0
//#define NULL ((void *)0)

#define IS_NULL(param) ( param == NULL )

typedef enum {RST_OK = 0,RST_ERROR}result;

typedef unsigned char uint8; //无符号8位字符型变量
typedef signed char int8; //有符号8位字符型变量
typedef unsigned short uint16; // 无符号16位短整型变量
typedef signed short int16; // 有符号16位短整型变量
typedef unsigned int uint32; // 无符号32位整型变量
typedef signed int int32; // 有符号32位整型变量
typedef struct Int64 int64;
typedef float fp32; //单精度浮点数（32位长度）
typedef double fp64; //双精度浮点数（64位长度）

typedef unsigned char u8; //无符号8位字符型变量
typedef unsigned short u16; // 无符号16位短整型变量
typedef unsigned int u32; // 无符号32位整型变量

typedef struct Buffer {
	unsigned char* data;
	int bufSize;
	int readOff;
	int writeOff;
	int dataLen;
}Buffer;
extern result Buffer_set(struct Buffer* buf, unsigned char* cs, int size);
result Buffer_setReadData(struct Buffer* buf, unsigned char* cs, int dataLen);
extern result Buffer_reset(struct Buffer* buf);
extern result Buffer_clear(struct Buffer* buf);
extern int8 Buffer_canWrite(struct Buffer* buf);
extern int Buffer_freeSize(struct Buffer* buf);
extern void Buffer_write(struct Buffer* buf, unsigned char c);
extern int Buffer_read(struct Buffer* buf);

int16 Buffer_readShort(struct Buffer* buf);
int32 Buffer_readInt(struct Buffer* buf);
void Buffer_writeShort(struct Buffer* buf, uint16 v);
void Buffer_writeInt(struct Buffer* buf, int32 v);

#endif /* INC_UTIL_BUFFER1_H_ */
