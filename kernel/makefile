C_SRC_FILES = $(shell find $(SRC_DIR) -type f -name '*.c')
C_OBJ_FILES = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.c.o, $(C_SRC_FILES))

CPP_SRC_FILES = $(shell find $(SRC_DIR) -type f -name '*.cpp')
CPP_OBJ_FILES = $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.cpp.o, $(CPP_SRC_FILES))

ASM_SRC_FILES = $(shell find $(SRC_DIR) -type f -name '*.asm')
ASM_OBJ_FILES = $(patsubst $(SRC_DIR)/%.asm, $(OBJ_DIR)/%.asm.o, $(ASM_SRC_FILES))

OBJ_DIR = obj
SRC_DIR = src

AS = nasm
CC = gcc
CPP = g++
LD = ld
AS_FLAGS = -f elf32 -o
CC_FLAGS = -c -m32 -ffreestanding -fno-pie -fno-stack-protector -fno-builtin -nostdlib -nostdinc -Isrc/include -g -Wall -Wextra -Iinclude/private -Iinclude/public
CPP_FLAGS = -c -m32 -ffreestanding -fno-pie -fno-stack-protector -fno-builtin -nostdlib -nostdinc -Isrc/include -g -Wall -Wextra -Iinclude/private -Iinclude/public
LD_FLAGS = -T linker.ld -z noexecstack -nostdlib -g -m elf_i386 -L/usr/lib/gcc/x86_64-pc-linux-gnu/13.2.1/32/libgcc.a

.PHONY: all
all: mkdir kernel.bin

mkdir:
	mkdir -p $(OBJ_DIR)

.PHONY: clean
clean:
	@rm -rf $(OBJ_DIR)
	@rm -rf kernel.bin
	@echo "Cleaned!"

kernel.bin: $(C_OBJ_FILES) $(ASM_OBJ_FILES) $(CPP_OBJ_FILES)
	$(LD) $(LD_FLAGS) $^ -o $@

$(OBJ_DIR)/%.c.o: $(SRC_DIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CC_FLAGS) $< -o $@

$(OBJ_DIR)/%.cpp.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(dir $@)
	$(CPP) $(CC_FLAGS) $< -o $@

$(OBJ_DIR)/%.asm.o: $(SRC_DIR)/%.asm
	@mkdir -p $(dir $@)
	$(AS) $(AS_FLAGS) $@ $<
