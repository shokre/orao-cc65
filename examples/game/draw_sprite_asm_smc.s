
.import _map_data_tiles
.import _map_data_width
.import _gfx_data_tiles
.import _sprite_gfx_data
.import _sprite_mask_data

.export _draw_sprite_asm_smc
.export _draw_sprite_asm_smc_set_map_pos
.export _draw_sprite_asm_smc_set_draw_pos
.export _draw_sprite_asm_smc_map_advance

.include "orao_sys.inc"
.include "macros.inc"
.include "draw_global.inc"
.include "smc.inc"

.zeropage
; counters
draw_width: .res 1
draw_height: .res 1

; pointers
draw_pos_lo: .res 1

.segment "CODE"

; set map position of top left corner
.proc _draw_sprite_asm_smc_set_map_pos
    ; store A/X to MapStartPos
    SMC_StoreAddress spMapStartPos
    rts
.endproc

; set draw position on screen
.proc _draw_sprite_asm_smc_set_draw_pos
    ; store low byte for later
    sta draw_pos_lo
    ; store A/X to DrawStartPos
    SMC_StoreAddress spDrawStartPos
    rts
.endproc


.proc _draw_sprite_asm_smc_map_advance
    SMC_AddAddrLo spMapStartPos, _map_data_width
    bcc _skip
    SMC_OperateOnHighByte INC, spMapStartPos
_skip:

    rts
.endproc

.macro _advance_draw_ptrs_scanline
    ; inc just the lo byte because we are on same page
    SMC_AddAddrLo spDrawStartPos, #32

    ; inc tile scanline
    SMC_OperateOnHighByte INC, spTilesStartPos
    SMC_OperateOnHighByte INC, spSpriteMaskData
    SMC_OperateOnHighByte INC, spSpriteGfxData
.endmacro

; draw sprite on map - 2220 cy (2x2) - 819 cy
.proc _draw_sprite_asm_smc
    ; sprite tile index - loaded to A
    SMC_StoreLowByte spSpriteMaskData, A
    SMC_StoreLowByte spSpriteGfxData, A

    ; set low byte of tiles_start to 0 because tiles are page aligned
    lda #0
    SMC_StoreLowByte spTilesStartPos, A

    ; set draw dimensions
    ldx #_TMP_DRAW_HEIGHT
    stx draw_height

    ; set draw len
    ldx #2
    dex
    stx draw_width

    ; init tiles location
    lda #>_gfx_data_tiles
    SMC_StoreHighByte spTilesStartPos, A
    lda #>_sprite_mask_data
    SMC_StoreHighByte spSpriteMaskData, A
    lda #>_sprite_gfx_data
    SMC_StoreHighByte spSpriteGfxData, A

    jsr _draw_sprite_scanline
    ;; draw next line
    _advance_draw_ptrs_scanline
    jsr _draw_sprite_scanline
    ;; draw next line
    _advance_draw_ptrs_scanline
    jsr _draw_sprite_scanline
    ;; draw next line
    _advance_draw_ptrs_scanline
    jsr _draw_sprite_scanline
    ;; draw next line
    _advance_draw_ptrs_scanline
    jsr _draw_sprite_scanline
    ;; draw next line
    _advance_draw_ptrs_scanline
    jsr _draw_sprite_scanline
    ;; draw next line
    _advance_draw_ptrs_scanline
    jsr _draw_sprite_scanline
    ;; draw next line
    _advance_draw_ptrs_scanline
    jmp _draw_sprite_scanline
.endproc

; draw current scanline
.proc _draw_sprite_scanline
    ldx draw_width
_draw:
    ; load map byte
    SMC spMapStartPos, { ldy SMC_AbsAdr,x }
    ; load tile byte from map byte
    SMC spTilesStartPos, { lda SMC_AbsAdr,y }

    ; AND with sprite mask
    SMC spSpriteMaskData, { AND SMC_AbsAdr,x }
    ; OR with sprite gfx
    SMC spSpriteGfxData, { ORA SMC_AbsAdr,x }

    ; write to screen
    SMC spDrawStartPos, { sta SMC_AbsAdr,x }

    dex
    bpl _draw
    rts
.endproc

SMC_Export spMapStartPos, _draw_sprite_scanline::spMapStartPos
SMC_Export spTilesStartPos, _draw_sprite_scanline::spTilesStartPos
SMC_Export spSpriteMaskData, _draw_sprite_scanline::spSpriteMaskData
SMC_Export spSpriteGfxData, _draw_sprite_scanline::spSpriteGfxData
SMC_Export spDrawStartPos, _draw_sprite_scanline::spDrawStartPos
