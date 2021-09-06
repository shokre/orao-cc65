
RUNTIME_DIR = ../../libsrc

LIB_FILE = $(RUNTIME_DIR)/orao.lib
INCLUDE_FLAGS = -I $(RUNTIME_DIR)/orao
DXA_BIN = ../../../dxa-0.1.4/dxa

clean-lib:
	cd $(RUNTIME_DIR); make clean all
