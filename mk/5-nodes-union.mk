
csv_nodes_explicit := $(nodes_dir)/explicit-nodes.csv
csv_nodes_summarized := $(nodes_dir)/summarized-nodes.csv
csv_nodes_implicit := $(nodes_dir)/implicit-nodes.csv
csv_nodes := $(nodes_dir)/nodes.csv

# Build explicit nodes from csv_schema
nodes-explicit.csv: $(csv_nodes_explicit)
$(csv_nodes_explicit): $(rs_csv_bind) $(nodes_explicit_targets) | conjeture
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo ''

# Build summarized nodes from csv_base_node_list
nodes-summarized.csv: $(csv_nodes_summarized)
$(csv_nodes_summarized): $(rs_csv_bind) $(nodes_summarized_targets) | conjeture
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo ''

# Build implicit nodes from csv_schema and other joined lists (e.g. landholders)
nodes-implicit.csv: $(csv_nodes_implicit)
$(csv_nodes_implicit): $(rs_csv_bind) $(nodes_implicit_targets) | conjeture
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo ''

## Build all nodes (explicit, summarized and implicit)
nodes.csv: $(csv_nodes)
$(csv_nodes): $(rs_csv_bind) $(csv_nodes_explicit) $(csv_nodes_summarized) $(csv_nodes_implicit) | conjeture
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo ''








