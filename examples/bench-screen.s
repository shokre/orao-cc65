
.include "orao_sys.inc"

START:  
    
    jsr ORAO_SYS_PRINT_NEWLINE
    lda #'o'
    jsr ORAO_SYS_VEC_PUTC
    lda #'r'
    jsr ORAO_SYS_VEC_PUTC
    lda #'a'
    jsr ORAO_SYS_VEC_PUTC
    lda #'o'
    jsr ORAO_SYS_VEC_PUTC
    jsr ORAO_SYS_PRINT_NEWLINE
    rts