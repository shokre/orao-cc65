
.include "orao_sys.inc"

.segment "CODE"

.export orao_fill_screen

; fill screen with A

.proc orao_fill_screen
    ldx #$00
_loop2:
    sta ORAO_MEM_VIDEO+$0000,X
    sta ORAO_MEM_VIDEO+$0100,X
    sta ORAO_MEM_VIDEO+$0200,X
    sta ORAO_MEM_VIDEO+$0300,X
    sta ORAO_MEM_VIDEO+$0400,X
    sta ORAO_MEM_VIDEO+$0500,X
    sta ORAO_MEM_VIDEO+$0600,X
    sta ORAO_MEM_VIDEO+$0700,X
    sta ORAO_MEM_VIDEO+$0800,X
    sta ORAO_MEM_VIDEO+$0900,X
    sta ORAO_MEM_VIDEO+$0A00,X
    sta ORAO_MEM_VIDEO+$0B00,X
    sta ORAO_MEM_VIDEO+$0C00,X
    sta ORAO_MEM_VIDEO+$0D00,X
    sta ORAO_MEM_VIDEO+$0E00,X
    sta ORAO_MEM_VIDEO+$0F00,X

    sta ORAO_MEM_VIDEO+$1000,X
    sta ORAO_MEM_VIDEO+$1100,X
    sta ORAO_MEM_VIDEO+$1200,X
    sta ORAO_MEM_VIDEO+$1300,X
    sta ORAO_MEM_VIDEO+$1400,X
    sta ORAO_MEM_VIDEO+$1500,X
    sta ORAO_MEM_VIDEO+$1600,X
    sta ORAO_MEM_VIDEO+$1700,X
    sta ORAO_MEM_VIDEO+$1800,X
    sta ORAO_MEM_VIDEO+$1900,X
    sta ORAO_MEM_VIDEO+$1A00,X
    sta ORAO_MEM_VIDEO+$1B00,X
    sta ORAO_MEM_VIDEO+$1C00,X
    sta ORAO_MEM_VIDEO+$1D00,X
    sta ORAO_MEM_VIDEO+$1E00,X
    sta ORAO_MEM_VIDEO+$1F00,X    
    dex
    bne _loop2
    rts
.endproc
