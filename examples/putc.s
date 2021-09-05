
.include "orao_sys.inc"

; PUTC example
;
; this example demonstrates usage of system routines
; to print a single char and advance cursor

START:  
    jsr ORAO_SYS_PRINT_NEWLINE
    
    ; print using vector
    lda #'o'
    jsr ORAO_SYS_VEC_PUTC
    lda #'r'
    jsr ORAO_SYS_VEC_PUTC
    
    ; call directly
    lda #'a'
    jsr ORAO_SYS_PUTC
    lda #'o'
    jsr ORAO_SYS_PUTC

    jsr ORAO_SYS_PRINT_NEWLINE
    rts
