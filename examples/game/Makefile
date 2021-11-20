
include ../shared.mk

FLAG_CFG = -C ../../cfg/orao.cfg

CA65_FLAGS = -t none --debug-info
CC65_FLAGS = -t none $(FLAG_CFG) --debug-info -O -Oi -Or -Os --static-locals --register-vars --add-source -I $(RUNTIME_DIR)/include

DA65_FLAGS = --comments 3 --start-addr '$$0400'

DEPS = $(patsubst %.c,%.o,$(wildcard *.c))
DEPS += $(patsubst %.s,%.o,$(wildcard *.s))

all: game.prg
	@echo ">> $^ built"

%.o: %.c
	cl65 $(CC65_FLAGS) -l $*.lst -c $<

%.o: %.s
	ca65 $(CA65_FLAGS) $(INCLUDE_FLAGS) $< -o $@

.PRECIOUS: %.prg
%.prg: $(DEPS)
	ld65 $(FLAG_CFG) --dbgfile $*.dbg -m $*.map -Ln $*.lbl $^ $(LIB_FILE) -o $@
	ls -l $@

%.da65.info:
	$(MAP2INFO_BIN) $*.map $*.lbl $*.dbg > $@

%.prg.dis: %.prg %.da65.info
	da65 -i $*.da65.info $*.prg > $@

clean:
	rm -f *.prg *.dis *.map *.dbg *.bin *.o *.lst *.da65.info *.lbl
