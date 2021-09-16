#include <orao.h>

// Hello world example

// Example using null terminated strings

void main(void) {
    char str[] = "Hello World!\n\r";

    orao_print_newline();
    orao_puts(str);
    orao_puts("Mikro\nRa[unalo\nORAO");
    orao_print_newline();
}