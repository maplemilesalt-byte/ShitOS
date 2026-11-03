all:
	nasm -f bin boot.asm -o boot.bin
	
	# 1. Compile Kernel
	gcc -m32 -O0 -ffreestanding -fno-pie -fno-stack-protector -fno-asynchronous-unwind-tables -fno-unwind-tables -c kernel.c -o kernel.o
	
	# 2. Compile keyboard
	gcc -m32 -O0 -ffreestanding -fno-pie -fno-stack-protector -fno-asynchronous-unwind-tables -fno-unwind-tables -c keyboard.c -o keyboard.o
	
	# 3. merge kernel and keyboard
	ld -m elf_i386 -Ttext 0x1000 -e kernel --oformat binary kernel.o keyboard.o -o kernel.bin

	# Check kernel size
	test $$(stat -c%s kernel.bin) -le 8704

	# 4. Make le file
	cat boot.bin kernel.bin > os-image.bin
