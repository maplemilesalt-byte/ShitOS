// ShitOS Kernel
// Fixd by ai, but the og was by me
#include "keyboard.h" // Adicione isso para o kernel conhecer o teclado

volatile unsigned char* video_memory =
    (volatile unsigned char*)0xB8000;

void kernel() {
    const char* str = "ShitOS IS RUNNING!!!";
    int i = 0;

    // Imprime a mensagem inicial do ShitOS
    while (str[i] != '\0') {
        video_memory[i * 2] = str[i];
        video_memory[i * 2 + 1] = 0x07; // Text Color
        i++;
    }

    int cursor_vga = 160; 

    // gets keyboard
    while (1) {
        char c = keyboard_get_char(); // get key from keyboard.c
        
        if (c != 0) {
            // If enter, go down
            if (c == '\n') {
                // CURSOR GOES BRRRRR
                cursor_vga = ((cursor_vga / 160) + 1) * 160;
            } 
            // If exists print
            else {
                video_memory[cursor_vga] = c;       // Place letter
                video_memory[cursor_vga + 1] = 0x0A;   // Gaster color
                cursor_vga += 2;                     // Goes 2 bytes on video
            }
        }
    }
}
