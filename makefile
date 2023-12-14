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
	grub-mkrescue -o os.iso bootloader/

.PHONY: run
run: bootloader
	@qemu-system-x86_64 -cdrom os.iso -gdb tcp::1234 -vga std -monitor stdio -m 512M