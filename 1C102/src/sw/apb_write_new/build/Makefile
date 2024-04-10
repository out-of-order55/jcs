# **********************************************
# ls1x project
# **********************************************
# Name of application

# **********************************************
# Tools
# **********************************************
#CROSS_COMPILE = loongarch32-linux-gnu-
#CROSS_COMPILE = loongarch32-linux-gnusf-
#CROSS_COMPILE =  /opt/loongarch32-linux-gnu-2022-04-15/bin/loongarch32-linux-gnu-

CC        = $(CROSS_COMPILE)gcc$(EXE)
LD        = $(CROSS_COMPILE)ld$(EXE)
OBJCOPY   = $(CROSS_COMPILE)objcopy$(EXE)
OBJDUMP   = $(CROSS_COMPILE)objdump$(EXE)
STRIP     = $(CROSS_COMPILE)strip$(EXE)
SIZE	  = $(CROSS_COMPILE)size$(EXE)

# **********************************************
# Directories
# **********************************************
BUILD_DIR = $(ROOT_DIR)/build
TARGET	  = $(ROOT_DIR)/target
PUBLIC	  = $(ROOT_DIR)/public
USER      = $(ROOT_DIR)/user
DRIVER    = $(ROOT_DIR)/driver
TOOL   	  = $(ROOT_DIR)/tool

BOARD = 1c102
BOARDNAME = LS1C102
IMAGENAME = 1c102_demo
PRIVATE	  = $(ROOT_DIR)/private
#BCMDLINE  = $(ROOT_DIR)/user/$(BOARD)_cmdline.o
BCMDLINE  = $(ROOT_DIR)/user/main.o
BCOMMAND  = $(ROOT_DIR)/user/$(BOARD)_cmd.o
BINT      = $(ROOT_DIR)/user/$(BOARD)_Interrupt.o

SRCDIR    = $(TARGET) $(PUBLIC) $(PRIVATE)  $(DRIVER) $(TOOL)
VPATH     = $(SRCDIR) $(USER)

# **********************************************
# Image file names and map file
# **********************************************
IMAGE_ELF = $(IMAGENAME).elf
IMAGE_BIN = $(IMAGENAME).bin
IMAGE_MAP = $(IMAGENAME).map

# **********************************************
# Compiler and linker options
# **********************************************
INCLUDE	+= -I$(ROOT_DIR)/include -I$(ROOT_DIR)/public -I$(PRIVATE) -I$(TARGET) -I$(DRIVER) -I$(TOOL)

FLAGS   = -std=gnu99 -O0 -ffunction-sections -fdata-sections -msoft-float -fsched-pressure -fno-builtin -D $(BOARDNAME) 

CC_OPTS	 = $(DEBUG) $(FLAGS) $(INCLUDE) 
CC_COPTS = $(DEBUG) $(FLAGS) $(INCLUDE) 

LD_SCRIPT = ld.script
LD_OPTS   = -G 0 -static -T $(LD_SCRIPT) -Map $(IMAGE_MAP) --gc-sections

# **********************************************
# Files to be compiled
# **********************************************

SRC_C  = $(foreach dir, $(SRCDIR), $(wildcard $(dir)/*.c))
SRC_S  = $(foreach dir, $(SRCDIR), $(wildcard $(dir)/*.S))
SRC    = $(SRC_C) $(SRC_S)
OBJ_C  = $(notdir $(patsubst %.c, %.o, $(SRC_C)))
OBJ_C += $(notdir $(BCMDLINE))
OBJ_C += $(notdir $(BCOMMAND))
OBJ_C += $(notdir $(BINT))
OBJ_S  = start.o $(filter-out start.o, $(notdir $(patsubst %.S, %.o, $(SRC_S))))
LS1C1X_OBJ = $(OBJ_S) $(OBJ_C)

# **********************************************
# Rules
# **********************************************
.PHONY : all
all : $(IMAGE_BIN) 
$(IMAGE_BIN):$(LS1C1X_OBJ) 
	$(LD) $(LD_OPTS) -o $(IMAGE_ELF) $^ -Map $(IMAGE_MAP)
	$(OBJCOPY) -O binary $(IMAGE_ELF) $(IMAGE_BIN)
	$(SIZE) $(IMAGE_ELF)
	$(OBJDUMP) -alD $(IMAGE_ELF) > $(IMAGENAME).s

$(OBJ_C) : %.o : %.c 
	$(CC) $(CC_COPTS) -c -o $@ $^
$(OBJ_S) : %.o : %.S
	$(CC) $(CC_OPTS) -c -o $@ $^


.PHONY : clean 
clean :
	rm -rf *.o *.elf *.map *.bin *.s *.a
