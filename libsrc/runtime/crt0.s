;
; Startup code for cc65 (orao version)
;

.export _exit
.export __STARTUP__ : absolute = 1      ; Mark as startup

.import _main
.import zerobss
.import initlib, donelib
.import __STACKSIZE__                   ; Linker generated

.include "orao_sys.inc"
.include "zeropage.inc"

.segment "EXEHDR"

    lda #<(ORAO_MEM_VIDEO - __STACKSIZE__)
    ldx #>(ORAO_MEM_VIDEO - __STACKSIZE__)
    sta sp
    stx sp+1            ; Set argument stack ptr
    jsr zerobss
    ; jsr initlib
    jsr _main
_exit: pha
    ; jsr donelib
    pla
    rts
