
.include "orao_sys.inc"
.include "zeropage.inc"

.segment "CODE"

.export _orao_puts_sys
.export _orao_puts
.export _orao_set_cur_pos

; print string terminated with 0x04

; C sends l:A h:X
; orao expects h:A,l:Y

; system version of puts which expects \x04 as terminating char
.proc _orao_puts_sys: near
    tay 
    txa
    jmp ORAO_SYS_PUTS
.endproc

; tmp var somwhere on zeropage
; ptr1 := $a2

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

.proc _orao_set_cur_pos: near
    sta $E9 ; x
    stx $E8 ; y
    jmp $e39d
.endproc