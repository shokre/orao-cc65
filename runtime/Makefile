
FLAG_CFG = -C ../cfg/orao-asm.cfg
TARGET = orao.lib
SOURCES = $(wildcard *.s)
DEPS = $(patsubst %.s,%.o,$(SOURCES))

all: $(TARGET)
	@echo ">> $(TARGET) BUILT"

$(TARGET): $(DEPS)
	rm -f $@
	ar65 a $@ $^

%.o: %.s
	ca65 -t c64 $< -o $@

clean:
	rm -f *.lib *.o