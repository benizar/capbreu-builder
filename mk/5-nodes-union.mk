
# Base node list
rs_nodes := $(rs_nodes_dir)/nodes.R
csv_nodes := $(patsubst $(rs_nodes_dir)/%.R,$(nodes_dir)/%.csv,$(rs_nodes))

# Merge all node files in one
nodes-union: $(csv_nodes)
	

$(csv_nodes): $(rs_nodes) $(nodes_summarized_targets) $(nodes_explicit_targets) $(nodes_implicit_targets) | checkdirs
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo ''	




