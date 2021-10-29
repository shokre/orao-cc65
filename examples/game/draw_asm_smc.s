
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

; draw map
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

_line_loop:
    jsr _draw_map_row

    ; advance map to next row
    SMC_AddAddrLo MapStartPos, _map_data_width
    bcc _skip
    SMC_OperateOnHighByte INC, MapStartPos
_skip:

    ; advance draw position onto next page
    SMC_OperateOnHighByte INC, DrawStartPos

    ; reset low byte
    SMC_TransferLowByte DrawStartPos, draw_pos_lo

    ; decrement height counter
    dec draw_height
    ; if not zero _line_loop
    bne _line_loop
    rts
.endproc

.macro _advance_draw_ptrs_scanline
    ; inc just the lo byte because we are on same page
    SMC_AddAddrLo DrawStartPos, #32

    ; inc tile scanline
    SMC_OperateOnHighByte INC, TilesStartPos
.endmacro

; draw a map row of 8 scanlines
.proc _draw_map_row
    ; init tiles location
    lda #>_gfx_data_tiles
    SMC_StoreHighByte TilesStartPos, A

    jsr _draw_map_scanline
    ;; draw next line
    _advance_draw_ptrs_scanline
    jsr _draw_map_scanline
    ;; draw next line
    _advance_draw_ptrs_scanline
    jsr _draw_map_scanline
    ;; draw next line
    _advance_draw_ptrs_scanline
    jsr _draw_map_scanline
    ;; draw next line
    _advance_draw_ptrs_scanline
    jsr _draw_map_scanline
    ;; draw next line
    _advance_draw_ptrs_scanline
    jsr _draw_map_scanline
    ;; draw next line
    _advance_draw_ptrs_scanline
    jsr _draw_map_scanline
    ;; draw next line
    _advance_draw_ptrs_scanline
    jmp _draw_map_scanline
.endproc

; draw current scanline
.proc _draw_map_scanline
    ldx draw_width
_draw:    
    ; load map byte
    SMC MapStartPos, { ldy SMC_AbsAdr,x }
    ; load tile byte from map byte
    SMC TilesStartPos, { lda SMC_AbsAdr,y }
    ; store byte to screen
    SMC DrawStartPos, { sta SMC_AbsAdr,x }

    dex
    bpl _draw
    rts
.endproc

SMC_Export MapStartPos, _draw_map_scanline::MapStartPos
SMC_Export TilesStartPos, _draw_map_scanline::TilesStartPos
SMC_Export DrawStartPos, _draw_map_scanline::DrawStartPos
