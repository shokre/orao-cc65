
void orao_print_debug(void);
void orao_print_newline(void);
void orao_print_space_hex_a(unsigned char);
void orao_print_addr(const char[]);

// system version of puts which expects \x04 as terminating char
void orao_puts_sys(const char[]);
// null terminated version of puts
void orao_puts(const char[]);
// start/stop timer
void orao_debug_timer(void);
// fill screen with byte value
void orao_fill_screen(unsigned char);
// int as y * 256 + x, x:h, y:l
void orao_set_cursor_pos(unsigned int);

// END OF FILE
