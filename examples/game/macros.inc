
; add A to word
.macro add16_a var_name
.scope
    clc
    adc var_name    ; add var lo byte to A
    sta var_name    ; store result to lo byte
    bcc _skip       ; skip hi byte if no carry
    inc var_name+1  ; inc hi byte if carry
_skip:
.endscope
.endmacro

; add value to word
.macro add16 var_name, value
    lda value
    add16_a var_name
.endmacro

; print value of a variable as hex address
.macro print_addr var_name
    lda var_name+1
    jsr ORAO_SYS_PRINT_HEX_A
    lda var_name
    jsr ORAO_SYS_PRINT_HEX_A
.endmacro


.macro SMC_AddAddrLo smc_name, value
    clc             ; 2cy
    lda value
    SMC_OperateOnLowByte ADC, smc_name
    SMC_StoreLowByte smc_name, A
.endmacro
