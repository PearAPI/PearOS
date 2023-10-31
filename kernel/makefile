C_SRC_FILES = $(shell find $(SRC_DIR) -type f -name '*.c')
C_OBJ_FILES = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(C_SRC_FILES))

ASM_SRC_FILES = $(shell find $(SRC_DIR) -type f -name '*.asm')
ASM_OBJ_FILES = $(patsubst $(SRC_DIR)/%.asm, $(OBJ_DIR)/%.o, $(ASM_SRC_FILES))

OBJ_DIR = obj
SRC_DIR = src

AS = nasm
CC = gcc
LD = ld
AS_FLAGS = -f elf64 -o
CC_FLAGS = -c -ffreestanding -fno-pie -fno-stack-protector -fno-builtin -nostdlib -nostdinc -Iinclude -g -Wall -Wextra
LD_FLAGS = -L linker.ld -Ttext 0x1000 -z noexecstack -nostdlib -g

.PHONY: all
all: mkdir kernel.bin

mkdir:
	mkdir -p $(OBJ_DIR)

.PHONY: clean
clean:
	@rm -rf $(OBJ_DIR)
	@rm -rf kernel.bin
	@echo "Cleaned!"

kernel.bin: $(C_OBJ_FILES) $(ASM_OBJ_FILES)
	$(LD) $(LD_FLAGS) $^ -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CC_FLAGS) $< -o $@
	echo $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.asm
	@mkdir -p $(dir $@)
	$(AS) $(AS_FLAGS) $@ $<
	echo $@