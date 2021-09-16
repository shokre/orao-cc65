#include <orao.h>

// Keyboard example

void main() {
    char c;

    orao_cls();
    orao_puts("ORAO cc65 == Keyboard example");
    orao_print_newline();
    orao_putc('\n');
    orao_puts("Press any key to see ASCII code value. Press <Q> to quit.");
    orao_print_newline();
    orao_putc('\n');
    asm("nop");
    do {
        c = orao_getc();
        orao_print_space_hex(c);
        orao_putc(':');
        orao_putc(c);
    } while(c != 'Q');
    orao_print_newline();
    orao_puts("END");
    orao_print_newline();
}