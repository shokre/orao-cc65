
.include "orao_sys.inc"
.include "smc.inc"

; Hello world example
;
; this example demonstrates usage of SMC (Self modifying code macros)
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
    nop
    ; put address in registers
    lda #<str1
    ldx #>str1
    ; write addres to 
;    SMC_StoreAddress LoadStrChar
;    SMC_StoreHighByte LoadStrChar, x
    SMC_TransferAddress LoadStrChar, #str1
    SMC_TransferAddress LoadStrChar2, #str1
    ldx #0
    SMC LoadStrChar, { lda SMC_AbsAdr,x }
    jsr ORAO_SYS_PRINT_SPACE_HEX_A
    ldx #1
    SMC LoadStrChar2, { lda SMC_AbsAdr,x }
    jsr ORAO_SYS_PRINT_SPACE_HEX_A
    nop
    rts

str1:
    .byte "Hello world!", $04

; $0A - LF
; $0D - CR

str2:
    .byte "Mikro" , $0A, "ra{unalo" , $0A, "ORAO", $04
  