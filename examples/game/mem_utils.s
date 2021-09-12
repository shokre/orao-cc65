.import _gfx_data_tiles

.export _mem_invert_bank

.include "smc.inc"

.proc _mem_invert_bank
    SMC_StoreAddress BankPos
    SMC_StoreAddress BankPos2

    ldx #$00
_loop2:
    SMC BankPos, { lda SMC_AbsAdr,X }
    eor #$ff
    SMC BankPos2, { sta SMC_AbsAdr,X }
    dex
    bne _loop2
    rts
.endproc
