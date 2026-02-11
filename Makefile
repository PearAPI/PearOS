CC = g++
CPP = g++
AS = nasm
LD = g++
CFLAGS = -m64 -mcmodel=kernel -fno-PIC -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs -Wall -Wextra -fno-exceptions -fno-rtti -ffreestanding -mno-red-zone -c -g 
ASFLAGS = -f elf64 -g -F dwarf
LDFLAGS = -T linker.ld -m64 -nostdlib -no-pie

INCLUDES = -Iinclude

BUILD_DIR = build

C_SOURCES = $(shell find src -name "*.c")
CPP_SOURCES = $(shell find src -name "*.cpp")
ASM_SOURCES = $(shell find src -name "*.asm")

C_OBJECTS = $(patsubst src/%.c, $(BUILD_DIR)/src/%.o, $(C_SOURCES))
CPP_OBJECTS = $(patsubst src/%.cpp, $(BUILD_DIR)/src/%.o, $(CPP_SOURCES))
ASM_OBJECTS = $(patsubst src/%.asm, $(BUILD_DIR)/src/%.o, $(ASM_SOURCES))

OBJECTS = $(C_OBJECTS) $(CPP_OBJECTS) $(ASM_OBJECTS)

all: $(BUILD_DIR)/os.iso

.PHONY: setup
setup:
	@echo $(CFLAGS) | tr " " "\n" > compile_flags.txt
	@echo "-x" >> compile_flags.txt
	@echo "c++" >> compile_flags.txt
	@echo $(INCLUDES) | tr " " "\n" >> compile_flags.txt

$(BUILD_DIR)/src/%.o: src/%.asm precompile
	@mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) $< -o $@

$(BUILD_DIR)/src/%.o: src/%.c precompile
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(INCLUDES) $< -o $@

$(BUILD_DIR)/src/%.o: src/%.cpp precompile
	@mkdir -p $(dir $@)
	$(CPP) $(CFLAGS) $(INCLUDES) $< -o $@

PRECOMPILE_SCRIPTS = $(wildcard scripts/*.py)

precompile:
ifneq ($(strip $(PRECOMPILE_SCRIPTS)),)
	@for script in $(PRECOMPILE_SCRIPTS); do \
		echo "Running $$script..."; \
		python3 $$script; \
	done
endif

kernel: $(OBJECTS)
	$(LD) $(LDFLAGS) $(INCLUDES) $(OBJECTS) -o $(BUILD_DIR)/pearos.bin

$(BUILD_DIR)/os.iso: kernel
	mkdir -p $(BUILD_DIR)/iso_root/boot/grub
	cp $(BUILD_DIR)/pearos.bin $(BUILD_DIR)/iso_root/boot/
	cp grub.cfg $(BUILD_DIR)/iso_root/boot/grub/
	@if [ -d "assets" ] && [ "$$(ls -A assets)" ]; then \
		cp -r assets/* $(BUILD_DIR)/iso_root/; \
	fi
	grub-mkrescue -o $(BUILD_DIR)/os.iso $(BUILD_DIR)/iso_root

clean:
	rm -rf $(BUILD_DIR)

run: $(BUILD_DIR)/os.iso
	qemu-system-x86_64 -cdrom $(BUILD_DIR)/os.iso -serial tcp::4444,server,nowait -serial stdio

debug: $(BUILD_DIR)/os.iso
	@echo "Waiting for debugger..."
	qemu-system-x86_64 -s -S -cdrom $(BUILD_DIR)/os.iso -serial tcp::4444,server,nowait -serial stdio

.PHONY: all clean run iso kernel debug
