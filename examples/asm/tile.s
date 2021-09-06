
.include "orao_sys.inc"

.import orao_fill_screen

; tile map example

.segment "CODE"

VID_SHIFT := $200
;tile_gfx2 := $E000 + 16*8

START:  
    lda #$55
    ;jsr orao_fill_screen
    ; num of tiles to draw
    ldx #05
    dex
_loop:
    lda tile_map,x
    tay
    lda tile_gfx,y
    sta ORAO_MEM_VIDEO+VID_SHIFT+0*32,x
    lda #$1
    sta ORAO_MEM_VIDEO+VID_SHIFT+2*32,x
    dex
    bpl _loop
    rts

; data not aligned
.segment "DATA"

tile_map:
    .byte 1, 0, 3, 2, 4, 5

; graphics data aligned to $100 page boundary
.segment "GFX_DATA"

tile_gfx:
    .byte 0, $ff, $0f, $f0, $55

.segment "GFX_DATA"

.align $100 ; align to next page boundary

tile_gfx2:
    .byte $aa, $bb, $cc
