
include ../shared.mk

FLAG_CFG = -C ../../cfg/orao.cfg

CA65_FLAGS = -t none --debug-info
CC65_FLAGS = -t none $(FLAG_CFG) --debug-info -O -Oi -Or -Os --static-locals --register-vars --add-source -I $(RUNTIME_DIR)/include

DA65_FLAGS = --comments 3 --start-addr '$$0400'

DEPS = $(patsubst %.c,%.o,$(wildcard *.c))
DEPS += $(patsubst %.s,%.o,$(wildcard *.s))

%.o: %.c
	cl65 $(CC65_FLAGS) -l $*.lst -c $<

%.o: %.s
	ca65 $(CA65_FLAGS) $(INCLUDE_FLAGS) $< -o $@

.PRECIOUS: %.prg
game.prg: $(DEPS)
	ld65 $(FLAG_CFG) --dbgfile game.dbg -m game.map $^ $(LIB_FILE) -o $@
	ls -l $@

%.prg.dis: %.prg
	$(DXA_BIN) -N -a dump $< > $@

clean:
	rm -f *.prg *.dis *.map *.dbg *.bin *.o *.lst
