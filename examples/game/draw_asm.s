
.import _map_data_tiles
.import _map_data_width
.import _gfx_data_tiles

.export _draw_asm_map
.export _draw_asm_set_map_pos
.export _draw_asm_set_draw_pos

.include "orao_sys.inc"
.include "macros.inc"
.include "draw_global.inc"

.macro _advance_draw_ptrs_scanline
    ; inc draw_pos
    ; inc just the lo byte because we are on same page
    clc             ; 2cy
    lda #32         ; 2cy
    adc draw_start  ; 3cy
    sta draw_start  ; 3cy

    ; inc tile scanline
    inc tiles_start+1
    ; set draw len
    ldx #_TMP_DRAW_LEN
    dex
    stx draw_width
.endmacro


.zeropage
; counters
draw_width: .res 1
draw_height: .res 1

; pointers
draw_pos_lo: .res 1
draw_start: .res 2
tiles_start: .res 2
map_start: .res 2

.segment "CODE"

; set map position of top left corner
.proc _draw_asm_set_map_pos
    sta map_start
    stx map_start+1
    rts
.endproc

; set draw position on screen
.proc _draw_asm_set_draw_pos
    sta draw_start
    ; store low byte for later
    sta draw_pos_lo
    stx draw_start+1
    rts
.endproc

; draw map
.proc _draw_asm_map
    ; set draw len
    ldx #_TMP_DRAW_HEIGHT
    stx draw_height

_line_looop:
    jsr _draw_map_row

    ; advance map
    add16 map_start, _map_data_width

    ; advance draw position onto next page
    inc draw_start+1
    ; reset low byte
    lda draw_pos_lo
    sta draw_start

    ; decrement height counter
    dec draw_height
    ; if not zero _line_looop
    bne _line_looop
    rts
.endproc

; draw a map row of 8 scanlines
.proc _draw_map_row
    ; init tiles location
    lda #>_gfx_data_tiles
    sta tiles_start+1
    lda #0
    sta tiles_start

    ; set draw len
    ldx #_TMP_DRAW_LEN
    dex
    stx draw_width

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
    jsr _draw_map_scanline

    rts
.endproc

; draw current scanline
.proc _draw_map_scanline
    ldy draw_width
_draw:    
    ; load map byte
    lda (map_start),y
    tay
    ; load gfx byte from map byte
    lda (tiles_start),y
    ldy draw_width
    ;eor #$ff
    sta (draw_start),y

    dey
    sty draw_width
    bpl _draw
    rts
.endproc