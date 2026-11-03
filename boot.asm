; Idk assembly, so chatgpt dod this part
[org 0x7c00]
[bits 16]

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7c00
    sti

    ; Save BIOS boot drive
    mov [boot_drive], dl

    ; Read kernel from disk (starting at sector 2)
    mov ah, 0x02
    mov al, 16
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, [boot_drive]
    mov bx, 0x1000
    int 0x13

    jc disk_error

    ; Jump to loaded kernel
    jmp 0x0000:0x1000

disk_error:
    mov si, error_msg

print_error:
    lodsb
    or al, al
    jz halt
    mov ah, 0x0e
    int 0x10
    jmp print_error

halt:
    cli
    hlt
    jmp halt

boot_drive db 0
error_msg db 'Disk read error!', 0

times 510 - ($ - $$) db 0
dw 0xaa55
