all:
	# 1. makes le bootloader
	nasm -f bin boot.asm -o boot.bin

	# 2. 32 bit kernel compiler
	gcc -m32 -ffreestanding -fno-pie -fno-stack-protector -c kernel.c -o kernel.o

	# 3. links kernel to 0x1000
	ld -m elf_i386 -Ttext 0x1000 --oformat binary kernel.o -o kernel.bin

	# 4. sixing mex
	cat boot.bin kernel.bin > os-image.bin

run: all
	# 5. Executa a imagem no emulador QEMU
	qemu-system-i386 -drive format=raw,file=os-image.bin

clean:
	rm -f *.bin *.o