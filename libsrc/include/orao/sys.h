#ifndef ORAO_SYS_H__
#define ORAO_SYS_H__

#include <orao/types.h>

// system version of puts which expects \x04 as terminating char
void orao_puts_sys(const char[]);
// null terminated version of puts
void orao_puts(const char[]);

// print cr+lf
void orao_print_newline(void);
// print space
void orao_print_space(void);
// print hex value
void orao_print_hex(i8);
// print space + hex value
void orao_print_space_hex_a(i8);
// print address of a pointer in hex
void orao_print_addr(const char[]);

#endif ORAO_SYS_H__
