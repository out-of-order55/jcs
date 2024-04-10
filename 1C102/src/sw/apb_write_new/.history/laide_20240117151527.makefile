ROOT_DIR  = $(shell pwd)
#ROOT_DIR  = $(PWD)
export

MCU := 1c102

PHONY := all
PHONY += help
PHONY += flash
PHONY += clean

LAIDE_PATH = C:/Users/Administrator/Desktop/LAIDE

CROSS_COMPILE =  $(LAIDE_PATH)/buildtool/la32-tool/bin/loongarch32-newlib-elf-
EXE = .exe
OPENOCD_PATH = $(LAIDE_PATH)/openocd/
OPENOCD_EXE = openocd.exe
OPENOCD_TOOL_CFG = lalink.cfg
OPENOCD_MCU_CFG = la132.cfg

all:
	@echo "***************************************************************************"
	@echo "*"
	@echo "*	Welcome loongson $(@)"
	@echo "*	This is $(@).bin."
	@echo "*"
	@echo "***************************************************************************"
	make  -C build clean
	make  -C build all
clean:
	make -C build clean
flash:
	$(OPENOCD_PATH)$(OPENOCD_EXE) -f $(OPENOCD_PATH)$(OPENOCD_TOOL_CFG) -f $(OPENOCD_PATH)$(OPENOCD_MCU_CFG) -c "program build/1c102_demo.bin 0x1c000000 exit"
help:
	@echo "this is help"
.PHONY: $(PHONY)
