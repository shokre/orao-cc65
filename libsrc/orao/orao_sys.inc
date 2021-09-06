ORAO_MEM_VIDEO = $6000
ORAO_MEM_SOUND = $8800

; vectors
; call putc via vector
ORAO_SYS_VEC_PUTC := $FFF1

; sys putc(A)
ORAO_SYS_PUTC := $E762
; sys puts(>A,<Y)
ORAO_SYS_PUTS := $E63B
; sys print CR+LF
ORAO_SYS_PRINT_NEWLINE := $E7F6

; set cursor pos x:$E9 y:$E8
ORAO_SYS_SET_CUR_POS := $E39D

; print space + A register as hex
ORAO_SYS_PRINT_SPACE_HEX_A := $E800

; print A register as hex
ORAO_SYS_PRINT_HEX_A := $E803

; external routines
ORAO_EXT_DEBUG_TIMER := $A001
