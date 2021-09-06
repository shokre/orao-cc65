
.include "orao_sys.inc"
.include "zeropage.inc"

.segment "CODE"

.export _orao_puts_sys

; print string terminated with 0x04

; C sends l:A h:X
; orao expects h:A,l:Y

; system version of puts which expects \x04 as terminating char
.proc _orao_puts_sys: near
    tay 
    txa
    jmp ORAO_SYS_PUTS
.endproc
