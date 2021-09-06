


void main() {
    char str[] = "Hello world!\x04";
    // char c = 4;
    // char o = 0x30;
    // char d = o + c;
    // asm("jsr $fff1");
    asm("lda #>%v", str);
    asm("jsr $e800");
    asm("lda #<%v", str);
    asm("jsr $e800");
    asm("lda #>%v", str);
    asm("ldy #<%v", str);
    asm("jsr $E63B");
    asm("jsr $E7F6");
}
