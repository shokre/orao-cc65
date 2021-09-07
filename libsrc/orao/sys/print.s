
.include "orao_sys.inc"

.segment "CODE"

.export _orao_print_newline
.export _orao_print_space

.export _orao_print_space_hex
.export _orao_print_space_hex_a

.export _orao_print_hex
.export _orao_print_hex_a

; orao system routines

_orao_print_newline := ORAO_SYS_PRINT_NEWLINE
_orao_print_space := ORAO_SYS_PRINT_SPACE

_orao_print_hex := ORAO_SYS_PRINT_HEX_A
_orao_print_hex_a := ORAO_SYS_PRINT_HEX_A

_orao_print_space_hex := ORAO_SYS_PRINT_SPACE_HEX_A
_orao_print_space_hex_a := ORAO_SYS_PRINT_SPACE_HEX_A
