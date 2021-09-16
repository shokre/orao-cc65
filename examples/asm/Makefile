
include ../shared.mk

FLAG_CFG = -C ../../cfg/orao-asm.cfg

CA65_FLAGS = -t none --debug-info
DA65_FLAGS = --comments 3 --start-addr '$$0400'

TARGETS = $(patsubst %.s,%,$(wildcard *.s))

all: $(patsubst %,%.prg,$(TARGETS))
	@echo "DONE"

all-dis: $(patsubst %,%.prg.dis,$(TARGETS))
	@echo "DONE"

%.o: %.s
	ca65 $(CA65_FLAGS) $(INCLUDE_FLAGS) $< -o $@

.PRECIOUS: %.prg
%.prg: %.o
	ld65 $(FLAG_CFG) --dbgfile $*.dbg -m $*.map $< $(LIB_FILE) -o $@
	ls -l $@

%.prg.dis: %.prg
	$(DXA_BIN) -N -a dump $< > $@

clean:
	rm -f *.prg *.dis *.map *.dbg *.bin