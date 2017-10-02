
# Include ordered mks
mks := $(sort $(wildcard mk/*.mk))
include $(mks)


## Build all files and outputs from the begining
all: conjeture nodes.csv edges.csv


.PHONY: clean
## Clean conjeture stored at builds dir
clean:
	@echo ''
	@echo 'Cleaning project ...'
	@$(RM) -rf $(builds_dir)
	@echo 'Removed everything that was created using this Makefile.'
	@echo ''

