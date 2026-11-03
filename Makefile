
all:
	# Compile kernel
	gcc -m32 -O0 -ffreestanding -fno-pie -fno-stack-protector -fno-asynchronous-unwind-tables -fno-unwind-tables -c kernel.c -o kernel.o

	# Link kernel at 0x1000
	ld -m elf_i386 -Ttext 0x1000 -e kernel --oformat binary kernel.o -o kernel.bin

	# Check kernel size
	test $$(stat -c%s kernel.bin) -le 8192

	# Build bootloader
	nasm -f bin boot.asm -o boot.bin

	# Create disk image
	cat boot.bin kernel.bin > os-image.bin

	# Pad disk image to 17 sectors
	truncate -s 8704 os-image.bin

run: all
	qemu-system-i386 -drive format=raw,file=os-image.bin

clean:
	rm -f *.bin *.o
o
