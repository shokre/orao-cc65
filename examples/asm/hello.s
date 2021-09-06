
.include "orao_sys.inc"

; Hello world example
;
; this example demonstrates usage of system routines
; to print a $04 terminated string

START:
    jsr ORAO_SYS_PRINT_NEWLINE
    lda #>str1
    ldy #<str1
    jsr ORAO_SYS_PUTS
    jsr ORAO_SYS_PRINT_NEWLINE
    lda #>str2
    ldy #<str2
    jsr ORAO_SYS_PUTS
    jsr ORAO_SYS_PRINT_NEWLINE
    rts

str1:
    .byte "Hello world!", $04

; $0A - LF
; $0D - CR

str2:
    .byte "Mikro" , $0A, "ra{unalo" , $0A, "ORAO", $04
  