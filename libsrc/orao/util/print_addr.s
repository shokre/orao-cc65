
.include "orao_sys.inc"

.segment "CODE"

.export _orao_print_addr

.proc _orao_print_addr: near
    tay
    txa 
    jsr ORAO_SYS_PRINT_HEX_A
    tya
    jmp ORAO_SYS_PRINT_HEX_A
.endproc
