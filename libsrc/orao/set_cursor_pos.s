
.include "orao_sys.inc"

.segment "CODE"

.export _orao_set_cursor_pos

; set cursor position
.proc _orao_set_cursor_pos: near
    sta $E9 ; x
    stx $E8 ; y
    jmp ORAO_SYS_SET_CUR_POS
.endproc
