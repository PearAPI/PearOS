.PHONY: all
all: kernel bootloader

.PHONY: clean
clean:
	@$(MAKE) -C kernel clean
	@rm -rf bootloader/boot/kernel.bin

.PHONY: kernel
kernel:
	@$(MAKE) -C kernel all

.PHONY: bootloader
bootloader: kernel
	@cp kernel/kernel.bin bootloader/boot/kernel.bin
	grub-mkrescue -o bootloader.iso bootloader

.PHONY: run
run: bootloader
	@qemu-system-x86_64.exe -cdrom os.iso -s -S