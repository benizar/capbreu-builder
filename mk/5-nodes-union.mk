
csv_nodes_explicit := $(nodes_all_dir)/explicit-nodes.csv
csv_nodes_summarized := $(nodes_all_dir)/summarized-nodes.csv
csv_nodes_implicit := $(nodes_all_dir)/implicit-nodes.csv
csv_nodes := $(nodes_all_dir)/all-nodes.csv

explicit-nodes: $(csv_nodes_explicit)
$(csv_nodes_explicit): $(rs_csv_folder_bind) $(nodes_explicit_dir) $(nodes_explicit_targets) | checkdirs
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(word 2, $^) $@
	@echo ''

summarized-nodes: $(csv_nodes_summarized)
$(csv_nodes_summarized): $(rs_csv_folder_bind) $(nodes_summarized_dir) $(nodes_summarized_targets) | checkdirs
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(word 2, $^) $@
	@echo ''

implicit-nodes: $(csv_nodes_implicit)
$(csv_nodes_implicit): $(rs_csv_folder_bind) $(nodes_implicit_dir) $(nodes_implicit_targets) | checkdirs
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(word 2, $^) $@
	@echo ''

## Create a CSV list containing all the nodes found in the schema
all-nodes: $(csv_nodes)
$(csv_nodes): $(rs_csv_folder_bind) $(nodes_all_dir) $(csv_nodes_explicit) $(csv_nodes_summarized) $(csv_nodes_implicit) | checkdirs
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(word 2, $^) $@
	@echo ''

