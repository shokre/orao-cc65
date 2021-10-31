.export _sprite_gfx_data
.export _sprite_mask_data

.segment "GFX_DATA"


_sprite_gfx_data:
  .byte	$00, $00, $30, $0c
  .align $100
  .byte	$00, $00, $f0, $0f
  .align $100
  .byte	$00, $00, $f0, $0f
  .align $100
  .byte	$00, $00, $c0, $03
  .align $100
  .byte	$c0, $03, $10, $04
  .align $100
  .byte	$60, $05, $a0, $0a
  .align $100
  .byte	$e0, $07, $00, $00
  .align $100
  .byte	$c0, $03, $00, $00
  .align $100

_sprite_mask_data:
  .byte	$ff, $ff, $07, $e0
  .align $100
  .byte	$ff, $ff, $07, $e0
  .align $100
  .byte	$ff, $ff, $07, $e0
  .align $100
  .byte	$1f, $f8, $07, $e0
  .align $100
  .byte	$0f, $f0, $07, $e0
  .align $100
  .byte	$0f, $f0, $07, $e0
  .align $100
  .byte	$0f, $f0, $0f, $e0
  .align $100
  .byte	$0f, $f8, $ff, $ff
  .align $100
