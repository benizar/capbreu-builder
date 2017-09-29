
# Include ordered mks
mks := $(sort $(wildcard mk/*.mk))
include $(mks)


## Create all files and outputs from the begining
all: nodes edges

## Build all nodes
nodes: $(nodes_explicit_targets) $(nodes_summarized_targets) $(nodes_implicit_targets)


graphs: $(gv_graph_full)

$(gv_graph_full): $(rs_graph_full) $(csv_nodes) $(csv_edges)

#---------------
# PATTERN RULES
#---------------
# Patern rule for Rscripts--arguments->html (visNetwork interactive)
$(builds_dir)/%.html: $(rscripts_dir)/%.R | checkdirs
	@echo ''
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $(@F)
	@mv $(@F) $@
	@echo ''

# Patern rule for Rscripts--arguments->gv (Graphviz DOT)
$(builds_dir)/%.gv: $(rscripts_graphs_dir)/%.R | checkdirs
	@echo ''
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo ''



.PHONY: clean
## Clean project
clean: | checkdirs
	@echo ''
	@echo 'Cleaning project ...'
	@$(RM) -rf $(builds_dir)
	@echo 'Removed everything that was created using this Makefile.'
	@echo ''

