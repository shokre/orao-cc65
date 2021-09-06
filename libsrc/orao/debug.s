
.include "orao_sys.inc"

.segment "CODE"

.export _orao_print_debug
.export _orao_print_newline
.export _orao_print_space_hex_a
.export _orao_debug_timer
.export _orao_print_addr

; fill screen with A

_orao_print_newline := ORAO_SYS_PRINT_NEWLINE
_orao_print_space_hex_a := ORAO_SYS_PRINT_SPACE_HEX_A

.proc _orao_print_debug: near
    lda #'O'
    jsr ORAO_SYS_PUTC
    lda #'R'
    jsr ORAO_SYS_PUTC
    lda #'A'
    jsr ORAO_SYS_PUTC
    lda #'O'
    jsr ORAO_SYS_PUTC
    rts
.endproc

.proc _orao_print_addr: near
    tay
    txa 
    jsr ORAO_SYS_PRINT_SPACE_HEX_A
    tya
    jmp ORAO_SYS_PRINT_HEX_A
.endproc


.proc _orao_debug_timer: near
    sta ORAO_EXT_DEBUG_TIMER
    rts
.endproc
