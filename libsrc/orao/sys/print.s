
.include "orao_sys.inc"

.segment "CODE"

.export _orao_getc
.export _orao_inkey

.export _orao_putc

.export _orao_print_newline
.export _orao_print_space

.export _orao_print_space_hex
.export _orao_print_space_hex_a

.export _orao_print_hex
.export _orao_print_hex_a

; orao system routines

_orao_getc := ORAO_SYS_GETC
_orao_inkey := ORAO_SYS_INKEY

_orao_putc := ORAO_SYS_PUTC

_orao_print_newline := ORAO_SYS_PRINT_NEWLINE
_orao_print_space := ORAO_SYS_PRINT_SPACE

_orao_print_hex := ORAO_SYS_PRINT_HEX_A
_orao_print_hex_a := ORAO_SYS_PRINT_HEX_A

_orao_print_space_hex := ORAO_SYS_PRINT_SPACE_HEX_A
_orao_print_space_hex_a := ORAO_SYS_PRINT_SPACE_HEX_A
