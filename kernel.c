// ShitOS Kernel
// Fixd by ai, but the og was by me
#include "keyboard.h" 

volatile unsigned char* video_memory =
    (volatile unsigned char*)0xB8000;

static inline void outb(unsigned short port, unsigned char value) {
    __asm__ volatile ("outb %0, %1" : : "a"(value), "Nd"(port));
}


void kernel() {
// Clear screen so all the bs is out
    for (int i = 0; i < 80 * 25 * 2; i += 2) {
        video_memory[i]     = ' ';  // Ovewrite bios trash
        video_memory[i + 1] = 0x07; // Make the background black
    }

    // ShitOS message
    const char* str = "ShitOS IS RUNNING!!!";
    int i = 0;

    while (str[i] != '\0') {
        video_memory[i * 2] = str[i];
        video_memory[i * 2 + 1] = 0x07; 
        i++;
    }

    // Type in line 2
    int cursor_vga = 160; 

    // Keyboard loop
    while (1) {
        char c = keyboard_get_char(); 
        
        if (c != 0) {
            if (c == '\n') {
                cursor_vga = ((cursor_vga / 160) + 1) * 160;
            } 
            else {
                video_memory[cursor_vga] = c;       
                video_memory[cursor_vga + 1] = 0x0A;   // Gaster Color
                cursor_vga += 2;                     
            }
        }
    }
}
