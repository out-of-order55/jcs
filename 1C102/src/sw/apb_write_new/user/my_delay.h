#ifndef _MY_DELAY_H
#define _MY_DELAY_H

#ifdef __cplusplus
extern "C" {
#endif

/*
    delay right.
*/
#define my_delay_us(n)\
do {\
    unsigned d = ((n*118)>>7)+1;\
    while(d--)\
    {\
        asm volatile("nop;nop;nop;nop");\
    }\
}while(0)

#define my_delay_ms(n) my_delay_us(1013*n) //ms

#ifdef __cplusplus
}
#endif

#endif // _MY_DELAY_H


