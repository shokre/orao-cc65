#ifndef ORAO_SYS_H__
#define ORAO_SYS_H__

#include <orao/types.h>

// print char
void orao_putc(char);
// system version of puts which expects \x04 as terminating char
void orao_puts_sys(const char[]);
// null terminated version of puts
void orao_puts(const char[]);
// get char from keyboard
char orao_getc(void);

// print cr+lf
void orao_print_newline(void);
// print space
void orao_print_space(void);
// print hex value of register A
void orao_print_hex_a(void);
// print hex value
void orao_print_hex(i8);
// print space + hex value of register A
void orao_print_space_hex_a(void);
// print space + hex value
void orao_print_space_hex(i8);
// print address of a pointer in hex
void orao_print_addr(const void *);

#endif ORAO_SYS_H__
