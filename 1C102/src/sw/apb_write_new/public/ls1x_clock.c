#include"ls1x_clock.h"
#include"ls1x_latimer.h"
#include"start.h"
uint32_t SystemFreq;
uint32_t CLOCK_IramToDramEn(void)
{
   PMU->CHIPCTRL |= (1<<25);/*iramas-d*/
   return 0;
}
/**
  * @brief  Waits for HSE start-up.
  * @param  None
  * @retval An ErrorStatus enumuration value:
  * - SUCCESS: HSE oscillator is  to be use
  * - ERROR: HSE oscillator not yet ready
  */

ErrorStatus CLOCK_WaitForHSEStartUp()
{
   uint32_t  tmp = 0x1000;
   ErrorStatus status = ERROR;
   PMU->CHIPCTRL |= CLOCK_SYSCLK_HSE_EN;
   do
   {
    	asm volatile("nop;");
   }while(tmp--);
   PMU->CHIPCTRL |= CLOCK_SYSCLK_HSE_SELECT;
   status = SUCCESS;

  return status;
}

ErrorStatus CLOCK_WaitForLSEStartUp(void)
{
  uint32_t tmp = 0;
  ErrorStatus status = ERROR;
  /* Wait till HSE is ready and if Time out is reached exit */
  do
  {
	  PMU->CHIPCTRL |= CLOCK_LSE_SELECT;
	   asm volatile("nop;\n");
  }while(PMU->CMDSTS & CLOCK_LSE_SELECT_STATUS != CLOCK_LSE_SELECT_STATUS);
   status = SUCCESS;
  return (status);
}
/******************************************************************************
 *Function Name：	 CLOCK_HSEConfig
 *Brief：Configures the External High Speed oscillator (HSE).
 *
 *Param：
 * 		 RCC_HSE: specifies the new state of the HSE.
 * 		 RCC_HSE_OFF: HSE oscillator OFF,system use internal 8M clock;
 * 		 RCC_HSE_ON: HSE oscillator ON,system use external 8M clock;
 *Return value：
 *       the state of function;
 *Remarks：
 *
 *
 ******************************************************************************/
ErrorStatus CLOCK_HSEConfig(uint32_t CLOCK_HSE)
{
	  uint32_t mode = 0,i = 0,clock = CLOCK_HSE;
	  ErrorStatus status = ERROR;
	  /* Check the parameters */
	  assert_param(IS_CLOCK_HSE(CLOCK_HSE));

	  /* reset the HSE bit  */
	  PMU->CHIPCTRL &= (uint32_t)~clock;
	  asm volatile("nop;\n");

	  if(clock == CLOCK_SYSCLK_HSE_SELECT)
	  {
		  status =  CLOCK_WaitForHSEStartUp();
	  }
	  else
	  {
		  PMU->CHIPCTRL &= ~CLOCK_SYSCLK_HSE_SELECT;
		  status = SUCCESS;
	  }

	  return status;
}


/******************************************************************************
 *Function Name：	 CLOCK_LSEConfig
 *Brief：Configures the External Low Speed oscillator (LSE 32K).
 *
 *Param：
 * 		 RCC_LSE: specifies the new state of the HSE.
 * 		 RCC_LSE_OFF: HSE oscillator OFF,system use internal 8M clock;
 * 		 RCC_LSE_ON: HSE oscillator ON,system use external 8M clock;
 *Return value：
 *		 the state of function;
 *Remarks：
 *
 *
 ******************************************************************************/
ErrorStatus CLOCK_LSEConfig(uint32_t CLOCK_LSE)
{
	  uint32_t mode = 0,clock = CLOCK_LSE;
	  ErrorStatus status = ERROR;
	  /* Check the parameters */
	  assert_param(IS_CLOCK_LSE(CLOCK_LSE));


	  /* set measure HSE div parameters*/
	  /* reset the LSE bit  */
	  PMU->CHIPCTRL &= (uint32_t)~CLOCK_LSE;


	  //asm volatile("nop;nop;nop;nop;\n");//需要延时函数确保屏幕


	  if( clock == CLOCK_LSE_SELECT)
	  {
		  status =  CLOCK_WaitForLSEStartUp();
	  }
	  else
	  {
		  status = SUCCESS;
	  }

	  return status;
}


/******************************************************************************
 *Function Name：	 CLOCK_StructInit
 *Brief：Fills each CLOCK_InitStruct member with its default value.
 *
 *Param：
 * 		 CLOCK_InitStruct: pointer to a CLOCK_InitTypeDef structurewhich will be initialized.
 *
 *Return value：
 *       None
 *Remarks：
 *
 ******************************************************************************/
void CLOCK_StructInit(CLOCK_InitTypeDef  *CLOCK_InitStruct)
{

	CLOCK_InitStruct->OscillatorType =CLOCK_OSCILLATORTYPE_HSE|CLOCK_OSCILLATORTYPE_HSI|CLOCK_OSCILLATORTYPE_LSE|CLOCK_OSCILLATORTYPE_LSI;
	CLOCK_InitStruct->HSEState = CLOCK_HSE_ON;
	CLOCK_InitStruct->LSEState = CLOCK_LSE_ON;
	CLOCK_InitStruct->LSISpeed = CLOCK_LSI_SPEED_32K;
	CLOCK_InitStruct->StartClkHS = CLOCK_START_CLK_HS_5140US;
        CLOCK_InitStruct->FastEn = CLOCK_FASTEN_OFF;

}

/******************************************************************************
 *Function Name：	 CLOCK_Init
 *Brief：Fills each CLOCK_InitStruct member with its default value.
 *
 *Param：
 * 		 CLOCK_InitStruct: pointer to a CLOCK_InitTypeDef structure which was initialized.
 *
 *Return value：
 *       the state of function;
 *Remarks：
 *
 ******************************************************************************/
ErrorStatus CLOCK_Init(CLOCK_InitTypeDef  *CLOCK_InitStruct)
{

	ErrorStatus status = ERROR;
	/* set HSE start delay time  */
	CLEAR_BIT(PMU->CHIPCTRL,CLOCK_START_CLK_HS_MASK);
	SET_BIT(PMU->CHIPCTRL,CLOCK_InitStruct->StartClkHS);

 	 /* set LSISpeed parameters*/
	CLEAR_BIT(PMU->CHIPCTRL,CLOCK_LSI_SPEED_MASK);
 	SET_BIT(PMU->CHIPCTRL,CLOCK_InitStruct->LSISpeed);
	

	/* set FASTEN parameters*/
	CLEAR_BIT(PMU->CHIPCTRL,CLOCK_FASTEN_MASK);
	SET_BIT(PMU->CHIPCTRL,CLOCK_InitStruct->FastEn);

	
    /**Initializes the HSE */
 	if (CLOCK_HSEConfig(CLOCK_InitStruct->HSEState) != SUCCESS)
 	{
 	  return status;
 	}
	/**Initializes the LSE */
 	if (CLOCK_LSEConfig(CLOCK_InitStruct->LSEState) != SUCCESS)
 	{
 	  return status;
 	}

	if (CLOCK_InitStruct->HSEState != CLOCK_HSE_ON ) {
		if (CLOCK_InitStruct->FastEn != 0x0){
			/* set FASTEN parameters*/
			CLEAR_BIT(PMU->CHIPCTRL,CLOCK_TURBO_MASK);
			SET_BIT(PMU->CHIPCTRL,CLOCK_InitStruct->TurboEn);
			if (ATE_Freq != 0) {
				SystemFreq = ATE_Freq * 4 / 3 * 1000;
			} else {
				SystemFreq = 10667000;
			}
		} else {
			if (ATE_Freq != 0) {
				SystemFreq = ATE_Freq * 1000;
			} else {
				SystemFreq = 8000000;
			}
		}
	} else {
		  SystemFreq =  8000000;
	}
	status = SUCCESS;
	return status;
}

/******************************************************************************
 *Function Name：	 CLOCK_GetFlagStatus
 *Brief：Checks which Clock is set or not.
 *
 *Param： CLCOK_FLAG: specifies the flag to check.
 * 		 CLOCK_FLAG_HSERDY: HSE oscillator clock ready
 *       CLOCK_FLAG_HSEFAIL: HSE oscillator clock fail
 *		 CLOCK_FLAG_LSERDY: LSE oscillator clock ready
 *		 CLOCK_FLAG_LSEFAIL: LSE oscillator clock fail
 *
 *Return value：
 *       The new state of CLCOK_FLAG (SET or RESET).
 *Remarks：
 *
 ******************************************************************************/
FlagStatus CLOCK_GetFlagStatus(uint32_t CLCOK_FLAG)
{
	FlagStatus status = RESET;
	assert_param(IS_CLOCK_FLAG(CLCOK_FLAG));
	status = PMU->CMDSTS & CLCOK_FLAG;
	return status;
}

/******************************************************************************
 *Function Name：	 CLOCK_GetClocksFreq
 *Brief：get the inner clock frequency  value.
 *
 *Param：
 * 		 Clocks : the inner clock frequency  value .
 *
 *Return value：
 *       none
 *Remarks：
 *
 ******************************************************************************/
uint32_t CLOCK_GetClocksFreq(void)
{
    	   open_count();
	   uint32_t tmp = 0;
	    asm volatile(					\
	       /* "nop;nop;nop;\n"			\ */
			"li.w	$r13, %1;\n"		\
			"li.w 	$r16, 0xfffff;\n"	\
			"rdtimel.w $r14, $r0;\n"	\
			"ld.w 	$r17, $r13, 0x08;\n"	\
			"addi.w $r17, $r17, 0x40;\n"	\
			"and 	$r16, $r16, $r17;\n"	\
			"1: \n"						\
			"ld.w 	$r15, $r13, 0x08;\n"	\
			"bne 	$r15, $r16, 1b ;\n"	\
			"nop;\n"					\
			"rdtimel.w $r18, $r0;\n"	\
			"sub.w $r18, $r18, $r14;\n"	\
			"slli.w %0, $r18, 0x02;\n"		\
			/*"nop;\n" */
	        :"=r"(tmp)	\
	        :"i"(PMU_BASE)	\
	        :"$r18","$r13","$r14","$r15","$r16","$r17"	\
	        );
     	    close_count();
	    return tmp;
}

uint32_t SystemClockInit(void)
{
    CLOCK_InitTypeDef  CLOCK_InitStruct = {0};
    
    CLOCK_StructInit(&CLOCK_InitStruct);

    CLOCK_InitStruct.OscillatorType = CLOCK_OSCILLATORTYPE_HSI | CLOCK_OSCILLATORTYPE_HSE | CLOCK_OSCILLATORTYPE_LSI | CLOCK_OSCILLATORTYPE_LSE;  //ls1c102
    CLOCK_InitStruct.HSEState = CLOCK_HSE_OFF;
    CLOCK_InitStruct.LSEState = CLOCK_LSE_ON;
    CLOCK_InitStruct.LSISpeed = CLOCK_LSI_SPEED_32K;
    CLOCK_InitStruct.StartClkHS = CLOCK_START_CLK_HS_5140US;    
    CLOCK_InitStruct.FastEn = CLOCK_FASTEN_OFF;
    CLOCK_InitStruct.TurboEn = CLOCK_TURBO_ON;
    
    if(CLOCK_Init(&CLOCK_InitStruct) != SUCCESS)
    {
             return -1;
    }
    return 0;
}
