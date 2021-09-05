
all: ma.all
	@echo "> $@ done"

clean: ma.clean
	@echo "> $@ done"

ma.%:
	cd runtime; make $*
	cd examples; make $*
