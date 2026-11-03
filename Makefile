all:
	# Compile the bootloadee
	nasm -f bin boot.asm -o boot.bin
	
	echo '[bits 32]' > kernel_entry.asm
	echo '[extern kernel]' >> kernel_entry.asm
	echo 'global start' >> kernel_entry.asm
	echo 'start:' >> kernel_entry.asm
	echo '    call kernel' >> kernel_entry.asm
	echo '    jmp $$' >> kernel_entry.asm
	
	nasm -f elf32 kernel_entry.asm -o kernel_entry.o
	
	# 1. Compile Kernel
	gcc -m32 -O0 -ffreestanding -fno-pie -fno-stack-protector -fno-asynchronous-unwind-tables -fno-unwind-tables -c kernel.c -o kernel.o
	
	# 2. Compile keyboard
	gcc -m32 -O0 -ffreestanding -fno-pie -fno-stack-protector -fno-asynchronous-unwind-tables -fno-unwind-tables -c keyboard.c -o keyboard.o
	
	# 3. merge kernel, entry and keyboard
	# ATENÇÃO: kernel_entry.o DEVE ser o primeiro arquivo da lista abaixo!
	ld -m elf_i386 -Ttext 0x1000 -e start --oformat binary kernel_entry.o kernel.o keyboard.o -o kernel.bin

	# Check kernel size (8704 bytes equivalem a 17 setores de 512 bytes)
	test $$(stat -c%s kernel.bin) -le 8704

	# 4. Make le file
	cat boot.bin kernel.bin > os-image.bin
