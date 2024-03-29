ORAO_MEM_VIDEO = $6000
ORAO_MEM_SOUND = $8800

; vector memory locations
ORAO_MEM_VEC_INKEY = $0216
ORAO_MEM_VEC_PUTC = $0218

; vectors
; call putc via vector
ORAO_SYS_VEC_PUTC := $FFF1
; call INKEY via vector
ORAO_SYS_VEC_INKEY := $FFEE

; get char from keyboard and store to A and $FC
ORAO_SYS_GETC := $E500

; read char from keyboard with echo, and store to A and $FC
ORAO_SYS_INKEY := $E71C

; sys putc(A)
ORAO_SYS_PUTC := $E762
; sys puts(>A,<Y)
ORAO_SYS_PUTS := $E63B
; sys print CR+LF
ORAO_SYS_PRINT_NEWLINE := $E7F6
; print space (preserving A register)
ORAO_SYS_PRINT_SPACE := $E7DC

; print space + A register as hex
ORAO_SYS_PRINT_SPACE_HEX_A := $E800

; print A register as hex
ORAO_SYS_PRINT_HEX_A := $E803

; set cursor pos x:$E9 y:$E8
ORAO_SYS_SET_CUR_POS := $E39D

; external routines
ORAO_EXT_DEBUG_TIMER := $A001
