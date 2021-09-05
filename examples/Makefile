
FLAG_CFG = -C ../cfg/orao-asm.cfg
LIB_FILE = ../runtime/orao.lib
INCLUDE_FLAGS = -I ../runtime
CA65_FLAGS = -t none --debug-info
DA65_FLAGS = --comments 3 --start-addr '$$0400'

TARGETS = $(patsubst %.s,%,$(wildcard *.s))

all: $(patsubst %,%.prg.dis,$(TARGETS))
	@echo "DONE"

%.o: %.s
	ca65 $(CA65_FLAGS) $(INCLUDE_FLAGS) $< -o $@

.PRECIOUS: %.prg
%.prg: %.o
	ld65 $(FLAG_CFG) --dbgfile $*.dbg -m $*.map $< $(LIB_FILE) -o $@
	ls -l $@

%.prg.dis: %.prg
	../../dxa-0.1.4/dxa -N -a dump $< > $@

clean:
	rm -f *.prg *.dis *.map *.dbg *.bin