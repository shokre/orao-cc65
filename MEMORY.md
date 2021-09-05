# Memory Map

- 0000-00FFh   CPU ZERO PAGE
  - 0214h - address of (00FE) FFE8 vector
- 0100-01FFh   CPU STACK
- 0200-03FFh   MONITOR AND SYSTEM AREA
  - 0201h - SPECIAL CHARS mem page ptr (0 - use system mem page - E000h)
  - 0202h - UPPERCASE CHARS mem page ptr
  - 0203h - LOWERCASE CHARS mem page ptr
  - 0214h - address of (FFFF) FFEB vector
  - 0216h - address of INKEY (E71C) (FFEE vector)
  - 0218h - address of PUTC (E762) (FFF1 vector)
  - 021Ah - address of (FFFF) FFF4 vector NMI?
  - 021Ch - address of (FFFF) FFF7 vector
  - 0280h - start of MONITOR input buffer
- 0400-5FFFh   USER RAM (23K)
- 6000-7FFFh   VIDEO RAM (8K)
- 8000-9FFFh   HARDWARE IO AREA
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
  - FE67h - PLOT x:$E2 y:$E3
  - FE8bh - DRAW x:$E2 y:$E3 x2:$E4 y2:$E5
  - FF06h - CIR x:$E2 y:$E3 r:$F8
  - FF89h - RESET sekvenca
  - FFE8h - VECTOR to ???     (00FE)
  - FFEBh - VECTOR to ???     (0214)
  - FFEEh - VECTOR to ???     (0216)
  - FFF1h - VECTOR to PUTC(A) (0218) (p.171)
  - FFF4h - VECTOR to ???     (021A)
  - FFFAh - VECTOR to ???     (021C)

## Keyboard

see page 182-183


## Notes

- PUTC and OUTCH used interchangeably

## References

- Orao_prirucnik_102_103.pdf pg. 106

