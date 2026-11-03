[org 0x7c00]          ; BIOS! LOAD THIS ADRESS!! GO WORK!! (btw 0x7c00 is rule, never change it)
[bits 16]

start:
    ; Configura segmentos de dados
    xor ax, ax ; ax is a speed variable, xor rule is: compares to bytes, if equal 0, or else 1
    mov ds, ax ; ds is a normal segment, since real mode is dumb and cant load ram
    mov es, ax ; es is extra, i think it writes, idk

    ; Pls enter the code for it
    ; ...

    ; lemme jump.. to the kernel.c yayayayay
    jmp 0x1000

times 510 - ($ - $$) db 0
dw 0xAA55             ; mbr signature
