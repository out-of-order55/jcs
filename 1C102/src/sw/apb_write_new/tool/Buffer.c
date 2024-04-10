/*
 * Buffer.c
 *
 *  Created on: 2021年1月21日
 *      Author: loongson
 */


/* Includes ------------------------------------------------------------------*/
#include "Buffer.h"

result Buffer_set(struct Buffer* buf, unsigned char* cs, int size){
	if(buf == NULL || cs == NULL) {
		return RST_ERROR;
	}

	buf->data = cs;
	buf->readOff = 0;
	buf->writeOff = 0;
	buf->dataLen = 0;
	if( cs == NULL || size <0 ) {
		buf->bufSize = 0;
	}
	else {
		buf->bufSize = size;
	}

	return RST_OK;
}

result Buffer_setReadData(struct Buffer* buf, unsigned char* cs, int dataLen){
	if(buf == NULL || cs == NULL) {
		return RST_ERROR;
	}

	buf->data = cs;
	buf->readOff = 0;
	buf->writeOff = 0;
	buf->dataLen = dataLen;
	if( cs == NULL || dataLen <0 ) {
		buf->bufSize = 0;
	}
	else {
		buf->bufSize = dataLen;
	}

	return RST_OK;
}

result Buffer_reset(struct Buffer* buf){
	if(buf == NULL) {
		return RST_ERROR;
	}

	buf->readOff = 0;
	buf->writeOff = 0;
	buf->dataLen = 0;

	return RST_OK;
}

result Buffer_clear(struct Buffer* buf){
	int i;
	if(buf == NULL || buf->bufSize <= 0) {
		return RST_ERROR;
	}

	Buffer_reset(buf);
	for(i = 0; i<buf->bufSize; i++)
		buf->data[i] = 0;

	return RST_OK;
}

int8 Buffer_canWrite(struct Buffer* buf) {
	if(buf->dataLen < buf->bufSize) {
		return 1;
	}
	return 0;
}

int Buffer_freeSize(struct Buffer* buf) {
	if(buf != NULL) {
		return buf->bufSize - buf->dataLen;
	}

	return 0;
}

//非阻塞模式读
int Buffer_read(struct Buffer* buf) {
	unsigned char c;

	if(buf->dataLen > 0){
		c = buf->data[buf->readOff];
		buf->readOff++;
		if(buf->readOff >= buf->bufSize){
			buf->readOff = 0;
		}
		buf->dataLen--;
		return c;
	}

	return -1;
}

int16 Buffer_readShort(struct Buffer* buf){
	int i;
	int16 v;

	v = 0;
	for( i=0; i<2; i++){
		v = ((v)<<8) | Buffer_read(buf);
	}

	return v;
}

int32 Buffer_readInt(struct Buffer* buf){
	int32 v;
	int i;

	v = 0;
	for( i=0; i<4; i++){
		v = ((v)<<8) | Buffer_read(buf);
	}

	return v;
}


void Buffer_write(struct Buffer* buf, unsigned char c) {
	buf->data[buf->writeOff] = c;
	buf->writeOff++;
	if(buf->writeOff >= buf->bufSize){
		buf->writeOff = 0;
	}

	buf->dataLen++;
	if(buf->dataLen > buf->bufSize){
		buf->dataLen = buf->bufSize;
		buf->readOff++;
    if(buf->readOff >= buf->bufSize)
      buf->readOff = 0;
	}
}

void Buffer_writeShort(struct Buffer* buf, uint16 v){
	int i;

	for( i=1; i>=0; i--){
		Buffer_write(buf, (v>>(i*8)) & 0xff);
	}
}

void Buffer_writeInt(struct Buffer* buf, int32 v){
	int i;

	for( i=3; i>=0; i--){
		Buffer_write(buf, (v>>(i*8)) & 0xff);
	}
}

uint8 Buffer_charToHalfChar(uint8 c){
  uint8 r;
  
  r = c;
  if(c>='0' && c <= '9')
    r -= '0';
  else if(c>='a' && c <= 'f')
    r -= 'a' - 10;
  else if(c>='A' && c <= 'F')
    r -= 'A' - 10;
  
  return r;
}

int Buffer_readHexChar(struct Buffer * buf){
  uint8 H,L;

  if(buf->dataLen < 2)
    return -1;
    
  H = Buffer_read(buf);
  L = Buffer_read(buf);
  H = Buffer_charToHalfChar(H);
  L = Buffer_charToHalfChar(L);
  H = (H<<4) + L;
  
  return H;
}




