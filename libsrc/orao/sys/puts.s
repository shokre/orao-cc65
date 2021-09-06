
.include "orao_sys.inc"
.include "zeropage.inc"

.segment "CODE"

.export _orao_puts

; null terminated version of puts
.proc _orao_puts: near
    sta ptr1 
    stx ptr1+1
    ldy #0
_loop:
    lda (ptr1),y
    beq _end_loop
    jsr ORAO_SYS_PUTC
    inc ptr1
    bne _loop
    inc ptr1+1
    bne _loop
_end_loop:
    rts
.endproc
