
.import _map_data_tiles
.import _map_data_width
.import _gfx_data_tiles
.import _sprite_gfx_data
.import _sprite_mask_data

.export _draw_sprite_asm_smc
.export _draw_sprite_asm_smc_set_sprite_pos
.export _draw_sprite_asm_smc_row_advance
.export _debug_sprite_struct
.export _map_row_ptr
.export _draw_row_ptr

.include "orao_sys.inc"
.include "macros.inc"
.include "draw_global.inc"
.include "smc.inc"

.zeropage
; counters
draw_width: .res 1
scanline_cnt: .res 1

; pointers
draw_pos_lo: .res 1

.segment "DATA"
_map_row_ptr: .res 64
_draw_row_ptr: .res 40

.segment "CODE"

.proc _debug_sprite_struct
    ; A:y X:x
    asl a
    tay
    lda _map_row_ptr+1, y
    jsr ORAO_SYS_PRINT_HEX_A
    txa
    adc _map_row_ptr, y
    jsr ORAO_SYS_PRINT_HEX_A

    rts
.endproc

; set map position of top left corner
.proc _draw_sprite_asm_smc_set_sprite_pos
    ; A:y X:x
    asl a
    tay
    lda _map_row_ptr+1, y
    SMC_StoreHighByte spMapStartPos, A
    lda _draw_row_ptr+1, y
    SMC_StoreHighByte spDrawStartPos, A

    txa
    adc _map_row_ptr, y
    SMC_StoreLowByte spMapStartPos, A

    txa
    adc _draw_row_ptr, y
    SMC_StoreLowByte spDrawStartPos, A
    sta draw_pos_lo

    rts
.endproc

.proc _draw_sprite_asm_smc_row_advance
    SMC_AddAddrLo spMapStartPos, _map_data_width
    bcc _skip
    SMC_OperateOnHighByte INC, spMapStartPos
_skip:
    SMC_OperateOnHighByte INC, spDrawStartPos
    SMC_TransferLowByte spDrawStartPos, draw_pos_lo

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

; draw sprite on map - 1662(+5) cy (2x2) - 810 cy (2x1)
.proc _draw_sprite_asm_smc
    ; sprite tile index - loaded to A
    SMC_StoreLowByte spSpriteMaskData, A
    SMC_StoreLowByte spSpriteGfxData, A

    ; set low byte of tiles_start to 0 because tiles are page aligned
    lda #0
    SMC_StoreLowByte spTilesStartPos, A

    ; draw 8 scanlines
    ldx #8
    stx scanline_cnt

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

_draw_scanline:
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

    ; next scanline
    dec scanline_cnt ; 5cy
    beq _finish     ; 2cy

    _advance_draw_ptrs_scanline

    jmp _draw_scanline ; 3cy
_finish:
    rts
.endproc

SMC_Export spMapStartPos, _draw_sprite_asm_smc::spMapStartPos
SMC_Export spTilesStartPos, _draw_sprite_asm_smc::spTilesStartPos
SMC_Export spSpriteMaskData, _draw_sprite_asm_smc::spSpriteMaskData
SMC_Export spSpriteGfxData, _draw_sprite_asm_smc::spSpriteGfxData
SMC_Export spDrawStartPos, _draw_sprite_asm_smc::spDrawStartPos
