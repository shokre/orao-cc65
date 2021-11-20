
.import _map_data_tiles
.import _map_data_width
.import _gfx_data_tiles

.export _draw_asm_smc_map
.export _draw_asm_smc_set_map_pos
.export _draw_asm_smc_set_draw_pos

.include "orao_sys.inc"
.include "macros.inc"
.include "draw_global.inc"
.include "smc.inc"

.zeropage
; counters
draw_width: .res 1
draw_height: .res 1
scanline_cnt: .res 1

; pointers
draw_pos_lo: .res 1

.segment "CODE"

; set map position of top left corner
.proc _draw_asm_smc_set_map_pos
    ; store A/X to MapStartPos
    SMC_StoreAddress MapStartPos
    rts
.endproc

; set draw position on screen
.proc _draw_asm_smc_set_draw_pos
    ; store low byte for later
    sta draw_pos_lo
    ; store A/X to DrawStartPos
    SMC_StoreAddress DrawStartPos
    rts
.endproc

; draw map 62992cy (for 20x20 area)
.proc _draw_asm_smc_map
    ; set low byte of tiles_start to 0 because tiles are page aligned
    lda #0
    SMC_StoreLowByte TilesStartPos, A

    ; set draw dimensions
    ldx #_TMP_DRAW_HEIGHT
    stx draw_height

    ; set draw len
    ldx #_TMP_DRAW_LEN
    dex
    stx draw_width

    ; start drawing
    jmp _row_loop

; this is ignored in first step
_draw_next_line:
    ; advance map to next row
    SMC_AddAddrLo MapStartPos, _map_data_width
    bcc __skip
    SMC_OperateOnHighByte INC, MapStartPos
__skip:

    ; advance draw position onto next page
    SMC_OperateOnHighByte INC, DrawStartPos
    ; reset low byte
    SMC_TransferLowByte DrawStartPos, draw_pos_lo

_row_loop:
    ; init tiles location
    lda #>_gfx_data_tiles
    SMC_StoreHighByte TilesStartPos, A

    ; draw 8 scanlines
    ldx #8
    stx scanline_cnt

_draw_map_scanline:
    ldx draw_width
_scanline_loop:
    ; load map byte
    SMC MapStartPos, { ldy SMC_AbsAdr,x }
    ; load tile byte from map byte
    SMC TilesStartPos, { lda SMC_AbsAdr,y }
    ; store byte to screen
    SMC DrawStartPos, { sta SMC_AbsAdr,x }

    dex
    bpl _scanline_loop

    ; next scanline
    dec scanline_cnt ; 5cy
    beq _finish_draw_scanline     ; 2cy

    ; inc just the lo byte because we are on the same page
    SMC_AddAddrLo DrawStartPos, #32 ; 10cy

    ; inc tile scanline
    SMC_OperateOnHighByte INC, TilesStartPos ; 6cy

    jmp _draw_map_scanline   ; 3cy

_finish_draw_scanline:

    ; decrement height counter
    dec draw_height
    bne _draw_next_line
    rts
.endproc

SMC_Export MapStartPos, _draw_asm_smc_map::MapStartPos
SMC_Export TilesStartPos, _draw_asm_smc_map::TilesStartPos
SMC_Export DrawStartPos, _draw_asm_smc_map::DrawStartPos
