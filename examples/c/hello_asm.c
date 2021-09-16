
// forward C variable to inline asm

void main() {
    char str[] = "Hello world!\x04";

    asm("lda #>%v", str);
    asm("jsr $e800");
    asm("lda #<%v", str);
    asm("jsr $e800");
    asm("lda #>%v", str);
    asm("ldy #<%v", str);
    asm("jsr $E63B");
    asm("jsr $E7F6");
}
