#ifndef _LS1X_FLASH_H_
#define _LS1X_FLASH_H_
#include "test.h"


#define FLASH_KEY_UPDATE		         0xF0000000
#define FLASH_WRITE_CMD			         0xE0000000
#define FLASH_SLEEPMODE			         0xC0000000
#define FLASH_ERASE_CMD			         0xA0000000
#define FLASH_PROTECTAREA_UPDATE	     0x90000000
#define FLASH_PAGE_LATCH_CLEAR	         0x40000000
#define FLASH_INT_CLEAR				     0x30000000
#define FLASH_DATA_VERIFY			     0x10000000

#define FLASH_ADDR_MASK			         0x7ffff80

#define FLASH_Command_Daddr_OFFSET		 0
#define FLASH_Command_Daddr_MASK		 0xffff
#define FLASH_Command_Cmd_OFFSET		 28
#define FLASH_Command_Cmd_MASK			 0xf

#define FLASH_Command_erase_page		 (0xa<<FLASH_Command_Cmd_OFFSET)
#define FLASH_Command_prog_page			 (0xe<<FLASH_Command_Cmd_OFFSET)
#define FLASH_Command_clr_page_latch	 (0x4<<FLASH_Command_Cmd_OFFSET)
#define FLASH_Command_check_page		 (0x1<<FLASH_Command_Cmd_OFFSET)
#define FLASH_Command_update_key		 (0xf<<FLASH_Command_Cmd_OFFSET)
#define FLASH_Command_update_bound		 (0x9<<FLASH_Command_Cmd_OFFSET)
#define FLASH_Command_clr_int			 (0x3<<FLASH_Command_Cmd_OFFSET)

#define	LS1D_FLASH_ADDR			       	 0xbf000000
#define	LS1D_FLASH_TOTAL		         0x0001ffff		//128KB
#define FLASH_PAGE_SIZE			         128
#define	WORD_WIDTH				         4			//every time for wirte is word width.
#define IS_FLASH_ADDRESS(ADDRESS) (((ADDRESS) >= 0xbf000000) && ((ADDRESS) < 0xbf01FFFF))

#define FLASH_PE_FAILURE_IT                 ((uint32_t)0x020000)/* ��дʧ�� */
#define FLASH_PE_IT                        	((uint32_t)0x010000)/* ��д����*/
#define IRQ_FLASH       					((uint8_t)0x10)
#define IS_FLASH_CONFIG_IT(IT) (((IT) == FLASH_PE_IT) || ((IT) == FLASH_PE_FAILURE_IT))

#define FLASH_FLAG_VERIFCORRECT				((uint32_t)0x00000001)  /*!< FLASH Verify Correct flag */
#define FLASH_FLAG_VERIFEND					((uint32_t)0x00000002)  /*!< FLASH Verify End flag */
#define FLASH_FLAG_PEEND					((uint32_t)0x00000004)  /*!< FLASH Erase End flag */
#define FLASH_FLAG_NOPERMISSION				((uint32_t)0x00000008)  /*!< FLASH No Permission flag */

#define IS_FLASH_GET_FLAG(FLAG)  (((FLAG) == FLASH_FLAG_NOPERMISSION) || ((FLAG) == FLASH_FLAG_PEEND) || \
                                  ((FLAG) == FLASH_FLAG_VERIFEND) || ((FLAG) == FLASH_FLAG_VERIFCORRECT))


#define EraseTimeout          ((uint32_t)0x00002000)
#define ProgramTimeout        ((uint32_t)0x00001000)
//#define EraseTimeout          ((uint32_t)0x000B0000)
//#define ProgramTimeout        ((uint32_t)0x20000000)

typedef enum
{
	verif_correct = 1,
	verif_end = 2,
	pe_end = 4,
	no_permission = 8,
	FLASH_TIMEOUT = 16
}FLASH_Status;


void FLASH_ErasePage(uint32_t addr);									//FLASH页擦除
void FLASH_EraseUserFlash(uint32_t addr);								//FLASH擦除用户区
uint32_t FLASH_ReadPage(uint32_t addr, uint8_t *data, uint32_t num);			//FLASH页读取
uint8_t FLASH_WitePage(uint32_t addr, uint8_t *data, uint32_t num);	//FLASH页编程
uint8_t FLASH_WaitForPeEnd(uint32_t Timeout);					//FLASH等待编程结束
uint8_t FLASH_GetStatus(void);										//FLASH当前状态获取
FlagStatus FLASH_GetFlagStatus(uint32_t FLASH_FLAG);				//FLASH状态查询
void FLASH_ITConfig(uint32_t FLASH_IT, FunctionalState NewState);	//FLASH中断设置
void FLASH_ITCmd(FunctionalState NewState);	//FLASH中断设置
void FLASH_ClearIT(void);											//FLASH中断标志清除
void FLASH_WiteTest(uint32_t Page_Address,uint8_t Page_data);			//FLASH写测试
void FLASH_ReadTest(uint32_t addr);									//FLASH读测试

#endif
