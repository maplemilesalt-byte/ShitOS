
ENTRY(start)OUTPUT_FORMAT("binary") /* Makes it a pure binary */

SECTIONS
{
    . = 0x1000;          /* Bootloader adress */

    .text : {
        *(.text)         /* Mix the code */
    }

    .rodata : {
        *(.rodata)       /* Mix constaints and trings */
    }

    .data : {
        *(.data)         /* Mix 2 intialized ivariables */
    }

    .bss : {
        *(.bss)          /* Mix 2 unintialized ivariables */
    }
}
