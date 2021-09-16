#include <orao.h>

// console rutines test

void test_start(void) {
    asm("nop");
    orao_puts("<START>");
    asm("nop");
}

void main() {
    unsigned char b;
    char str[] = "Hello world!";

    asm("nop");
    orao_cls();

    orao_debug_init();
    test_start();

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
    for (b=0; b<3;b++) {
        orao_set_cursor_pos(b * 3 * 256);
        orao_puts("DEF\r\n");
        orao_puts("GHi");
        orao_puts("::()");
        orao_print_newline();
    }
}
