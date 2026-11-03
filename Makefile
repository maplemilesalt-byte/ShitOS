# chatgpt also did this
.PHONY: all run clean

all:
	nasm -f bin boot.asm -o boot.bin
	gcc -m32 -O0 -ffreestanding -fno-pie -fno-stack-protector -fno-asynchronous-unwind-tables -fno-unwind-tables -c kernel.c -o kernel.o
	ld -m elf_i386 -Ttext 0x1000 -e kernel --oformat binary kernel.o -o kernel.bin
	test $$(stat -c%s kernel.bin) -le 8192
	test $$(stat -c%s boot.bin) -eq 512
	cat boot.bin kernel.bin > os-image.bin
	truncate -s 8704 os-image.bin

run: all
	qemu-system-i386 -drive format=raw,file=os-image.bin

clean:
	rm -f *.bin *.o
