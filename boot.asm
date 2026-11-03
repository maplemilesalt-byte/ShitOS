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

    mov [boot_drive], dl

    ; Read kernel: 16 sectors (8192 bytes)
    mov ax, 0
    mov es, ax
    mov bx, 0x1000

    mov ah, 0x02
    mov al, 16
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, [boot_drive]

    sti
    int 0x13
    jc disk_error

    cli

    ; Load GDT
    lgdt [gdt_descriptor]

    ; Enable Protected Mode
    mov eax, cr0
    or eax, 1
    mov cr0, eax

    ; Far jump into 32-bit code
    jmp 0x08:protected_mode

disk_error:
    mov si, error_msg

print_error:
    lodsb
    test al, al
    jz halt

    mov ah, 0x0e
    int 0x10
    jmp print_error

halt:
    cli
    hlt
    jmp halt

[bits 32]

protected_mode:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    ; Set stack
    mov esp, 0x90000

    ; Jump to kernel
    mov eax, 0x1000
    jmp eax

; Global Descriptor Table

align 8

gdt_start:
    dq 0x0000000000000000

    ; Code segment
    dq 0x00CF9A000000FFFF

    ; Data segment
    dq 0x00CF92000000FFFF

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

boot_drive db 0
error_msg db 'Disk read error!', 0

times 510 - ($ - $$) db 0
dw 0xaa55
