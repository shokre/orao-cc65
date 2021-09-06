
.include "orao_sys.inc"

.segment "CODE"

.export _orao_debug_init
.export _orao_debug_timer

.proc _orao_debug_init: near
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

.proc _orao_debug_timer: near
    sta ORAO_EXT_DEBUG_TIMER
    rts
.endproc
