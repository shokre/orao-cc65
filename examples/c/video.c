#include <orao.h>
#define ORAO_MEM_VIDEO ((unsigned char*)0x6000)

// Video access example

void test_video(void)
{
    unsigned char x,y;

    // video_mem[1285] = 0xff;
    for (y = 0; y < 224; y+=32)
    for (x = 0; x < 10; x+=2) {
        ORAO_MEM_VIDEO[1282+y+x]= 0xFF;
    }
}

unsigned char *video_mem_start;

void main(void) {
    orao_cls();
    orao_puts("ORAO cc65 == Video example");
    orao_print_newline();
    asm("nop");
    // set video pointer to start of scanline
    //   start from x:1 y:3(*0xff)
    //   video_mem_start = $6301

    test_video();

    video_mem_start = (unsigned char*)0x6301;

    // write N bytes
    video_mem_start[0] = 0xff;
    video_mem_start[1] = 0x55;
}