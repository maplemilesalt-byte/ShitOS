// Start
void kernel() {
    // Fucking video rockssss

    const char* str = "ShitOS IS RUNNING!!!";
    int i = 0;

    while (str[i] != '\0') {
        video_memory[i * 2] = str[i];
        video_memory[i * 2 + 1] = 0x07; // Text attribute
        i++; // write the DAMN letter to their DAMN positions
    }

    // HELP ME!! I CANT STOP
    while (1) {
        __asm__("hlt");
    }
}
