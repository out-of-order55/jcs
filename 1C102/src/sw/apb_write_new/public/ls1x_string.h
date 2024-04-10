#ifndef _LS1X_STRING_H_
#define _LS1X_STRING_H_
#include "test.h"
int atoi(char *s);
void itoa(char chWord[], int Num);
int memcmp(const void *cs, const void *ct, int count);
void *memcpy(void *s1, const void *s2, int n);
void *memset(void *s, int c, int count);
char *strcat(char *dst, const char *src);
int strcmp(const char *s1, const char *s2);
char *strcpy(char *dest, const char *src);
int strlen(const char *p);
INT8U strstr(const INT8U *str, const INT8U *sub_str, INT8U num);
char *strchr(const char *s, char c);
char *pstrstr(const char *haystack, const char *needle);
int atohex(char *str);
#endif
