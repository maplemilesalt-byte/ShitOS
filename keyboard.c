// Keyboard code by ai
// at this point i cant make any other code :(
#include "keyboard.h"

unsigned char inb(unsigned short port) {
    unsigned char result;
    __asm__ __volatile__("inb %1, %0" : "=a"(result) : "Nd"(port));
    return result;
}

#define PS2_DATA_PORT   0x60
#define PS2_STATUS_PORT 0x64

unsigned char kbd_us[128] = {
    0,  27, '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', '\b',  
    '\t', 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\n',    
    0, 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', '\'', '`', 0,         
    '\\', 'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '/', 0, '*', 0, ' '
};

unsigned char keyboard_read_scancode() {
    while ((inb(PS2_STATUS_PORT) & 1) == 0) {
        // Wait for keyboard
    }
    return inb(PS2_DATA_PORT);
}

char keyboard_get_char() {
    unsigned char scancode = keyboard_read_scancode();
    if (!(scancode & 0x80)) {
        return kbd_us[scancode];
    }
    return 0;
}
