
all: ma.all
	@echo "> $@ done"

clean: ma.clean
	@echo "> $@ done"

ma.%:
	cd libsrc; make $*
	cd examples/asm; make $*
	cd examples/c; make $*
