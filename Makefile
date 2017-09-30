
# Include ordered mks
mks := $(sort $(wildcard mk/*.mk))
include $(mks)


## Create all files and outputs from the begining
all: nodes edges

## Build all nodes (explicit, summarized and implicit)
nodes: $(csv_nodes)

## Builds all edges (explicit and implitcit)
edges: $(csv_edges)


.PHONY: clean
## Clean project
clean: | checkdirs
	@echo ''
	@echo 'Cleaning project ...'
	@$(RM) -rf $(builds_dir)
	@echo 'Removed everything that was created using this Makefile.'
	@echo ''

