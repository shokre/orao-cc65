# Memory Map

- 0000-00FFh   CPU ZERO PAGE
  - 00FEh - address of FFE8h vector
- 0100-01FFh   CPU STACK
- 0200-03FFh   MONITOR AND SYSTEM AREA
  - 0201h - SPECIAL CHARS mem page ptr (0 - use system mem page - E000h)
  - 0202h - UPPERCASE CHARS mem page ptr
  - 0203h - LOWERCASE CHARS mem page ptr
  - 0214h - address of (FFFF) FFEB vector
  - 0216h - address of INKEY (E71C) (FFEE vector)
  - 0218h - address of PUTC (E762) (FFF1 vector)
  - 021Ah - address of (FFFF) FFF4 vector
  - 021Ch - address of (FFFF) FFF7 vector
  - 021Eh - address of IRQ (HW) handler
  - 0220h - address of NMI handler
  - 0222h - address of BRK (SW) handler
  - 0280h - start of MONITOR input buffer
- 0400-5FFFh   USER RAM (23K)
- 6000-7FFFh   VIDEO RAM (8K)
- 8000-9FFFh   HARDWARE IO AREA
  - 87FFh - tape input
  - 8800h - sound flip/flop
- A000-AFFFh   EXTENSION AREA
- B000-BFFFh   DOS ROM
- C000-DFFFh   BASIC ROM
- E000-FFFFh   SYSTEM/MONITOR ROM
  - E000h - Character generator
    - E000h - SPECIAL CHARS
    - E100h - UPPERCASE CHARS
    - E200h - LOWERCASE CHARS
  - E39Dh - SET CUR POS x:$E9 y:$E8 (p.173)
  - E4F4h - BEEP sound
  - E500h - ispitivanje KOJI je taster pritisnut GETC(A) -> $FC
  - E5B0h - ispitivanje DA LI je taster pritisnut
  - E63Bh - PUTS(h:A,l:Y) - terminate str with 0x04 (p.172)
  - E71Ch - unos znaka sa prikazom na ekranu - INKEY
  - E762h - PUTC(A) (p.160)
  - E79Fh - PADDLE rutina
  - E7B7h - prazna petlja za kašnjenje
  - E7DCh - ispis jednog praznog mjesta na ekran
  - E7E4h - ispis cetiri prazna mjesta (TAB 4)
  - E7EDh - konvertira akumulator A u hex ASCII vrijednost za ispis ($4 -> 52, $C -> 66)
  - E7F6h - ispis CR+LF na ekran
  - E800h - ispis praznog mjesta+sadrzaj akumulatora (heksa.)
  - E803h - ispis sadrzaj akumulatora (heksa.) (p.173)
  - E817h - ispis sadrzaja programskog brojila (hex)
  - E620h - adresa (B) BASIC BC/BW
  - E906h - adresa (U addr) EXEC
  - E90Eh - adresa (E start end) HEX DUMP
  - EAD0h - adresa (C start end) SUM
  - EBO9h - adresa (Q dest start end) COPY
  - EB48h - adresa (F start end b) FILL
  - EB6Ah - adresa (M [addr]) MEMORY EDIT
  - EBABh - adresa (A [addr]) ASSEMBLE
  - EC80h - adresa (X [addr]) DISASSEMBLE
  - EED0h - adresa (H [start] [end]) HEX DUMP + ASCII
  - EF57h - adresa (#nnnn) HEX2DEC
  - FE69h - PLOT x:$E2 y:$E3
  - FE8bh - DRAW x:$E2 y:$E3 x2:$E4 y2:$E5
  - FF06h - CIR x:$E2 y:$E3 r:$F8
  - FF72h - system IRQ/BRK handler
  - FF83h - system NMI handler
  - FF89h - system RESET handler
  - FFE8h - VECTOR JMP (00FE) ???
  - FFEBh - VECTOR JMP (0214) ???
  - FFEEh - VECTOR JMP (0216) INKEY->A
  - FFF1h - VECTOR JMP (0218) PUTC(A)   (p.171)
  - FFF4h - VECTOR JMP (021A) ???
  - FFFAh - VECTOR JMP (021C) ???
  - FFFAh - address of NMI handler (FF83)
  - FFFCh - address of reset handler (FF89)
  - FFFEh - address of IRQ handler (FF72)

## Keyboard

see page 182-183


## Notes

- PUTC and OUTCH used interchangeably

## References

- Orao_prirucnik_102_103.pdf pg. 106

