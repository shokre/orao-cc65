
FLAG_CFG = -C ../cfg/orao-asm.cfg
TARGET = orao.lib
ASM_INCLUDE_PATH = -I orao -I runtime

ASM_SOURCES = $(wildcard */*.s)
ASM_SOURCES += $(wildcard */*/*.s)

C_SOURCES = $(wildcard */*.c)
C_SOURCES += $(wildcard */*/*.c)

DEPS = $(patsubst %.s,%.o,$(ASM_SOURCES))
DEPS += $(patsubst %.c,%.o,$(C_SOURCES))

CC65_FLAGS = -t none $(FLAG_CFG) --debug-info -O -Oi -Or -Os --static-locals --register-vars --add-source -I include

all: $(TARGET)
	@echo ">> $(TARGET) BUILT"

$(TARGET): $(DEPS)
	rm -f $@
	ar65 a $@ $^

%.o: %.s
	ca65 -t none $< $(ASM_INCLUDE_PATH) -o $@

%.o: %.c
	cl65 $(CC65_FLAGS) -l $*.lst -c $<

clean:
	rm -f *.lib */*.o */*/*.o */*.lst */*/*.lst
