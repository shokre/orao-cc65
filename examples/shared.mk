
RUNTIME_DIR = ../../libsrc

LIB_FILE = $(RUNTIME_DIR)/orao.lib
INCLUDE_FLAGS = -I $(RUNTIME_DIR)/orao
DXA_BIN = ../../../dxa-0.1.4/dxa
MAP2INFO_BIN = ../../utils/map2info.py

clean-lib:
	cd $(RUNTIME_DIR); make clean all
