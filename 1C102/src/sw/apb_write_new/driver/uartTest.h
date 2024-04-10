/*
 * uartTest.h
 *
 *  Created on: 2023年9月6日
 *      Author: j
 */

#ifndef DRIVER_UARTTEST_H_
#define DRIVER_UARTTEST_H_

#include "test.h"

//收包初始化
void recv_buf_init();

//串口接收函数
void recv_dat_int(INT8U dat);

//收包测试函数
void test_recv_uart();

//发包测试函数
void test_uart_send();

#endif /* DRIVER_UARTTEST_H_ */
