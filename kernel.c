// ShitOS Kernel

volatile unsigned char* video_memory =
    (volatile unsigned char*)0xB8000;

void kernel() {
    const char* str = "ShitOS IS RUNNING!!!";
    int i = 0;

    while (str[i] != '\0') {
        video_memory[i * 2] = str[i];
        video_memory[i * 2 + 1] = 0x07;
        i++;
    }

    while (1) {
        __asm__ volatile ("hlt");
    }
}
