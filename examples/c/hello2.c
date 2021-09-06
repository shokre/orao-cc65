#include <orao.h>

//void test_start(void);

void main() {
    char str[] = "Hello world!";
    unsigned char b;
    //char c = 4;
    // char o = 0x30;
    // char d = o + c;
    // asm("jsr $fff1");
    asm("nop");
    //test_start();
    orao_fill_screen(0);
    orao_print_debug();
    orao_print_newline();
    asm("lda #>%v", str);
    asm("jsr $e800");
    asm("lda #<%v", str);
    asm("jsr $e800");
    orao_puts(" Adr:");
    orao_print_addr(str);
    orao_print_newline();
    orao_puts("xo");

    // asm("nop");
    orao_debug_timer();
    orao_puts(str);
    orao_debug_timer();
    orao_set_cursor_pos(12 * 256 + 3);
    orao_puts("abc");
    orao_set_cursor_pos(0);
    for (b=0; b<3;b++) {
        orao_set_cursor_pos(b * 3 * 256);
        orao_puts("DEF\r\n");
        orao_puts("GHi");
        orao_puts("::()");
        orao_print_newline();
    }
}
/*
void test_start(void) {
    asm("nop");
    orao_puts("START");
    asm("nop");
}
*/
