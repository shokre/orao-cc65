
.include "orao_sys.inc"

; video mem fill exmaple

START:  
    sta ORAO_EXT_DEBUG_TIMER
    lda #$55
    ldx #$00
_loop:
    sta ORAO_MEM_VIDEO+$0100,X
    sta ORAO_MEM_VIDEO+$0300,X
    sta ORAO_MEM_VIDEO+$0500,X
    sta ORAO_MEM_VIDEO+$0700,X
    sta ORAO_MEM_VIDEO+$0900,X
    sta ORAO_MEM_VIDEO+$0B00,X
    sta ORAO_MEM_VIDEO+$0D00,X
    sta ORAO_MEM_VIDEO+$0F00,X
    
    sta ORAO_MEM_VIDEO+$1100,X
    sta ORAO_MEM_VIDEO+$1300,X
    sta ORAO_MEM_VIDEO+$1500,X
    sta ORAO_MEM_VIDEO+$1700,X
    sta ORAO_MEM_VIDEO+$1900,X
    sta ORAO_MEM_VIDEO+$1B00,X
    sta ORAO_MEM_VIDEO+$1D00,X
    sta ORAO_MEM_VIDEO+$1F00,X
    dex
    bne _loop
    sta ORAO_EXT_DEBUG_TIMER
    rts
