
csv_edges_explicit := $(edges_all_dir)/explicit-edges.csv
csv_edges_implicit := $(edges_all_dir)/implicit-edges.csv
csv_edges := $(edges_all_dir)/all-edges.csv

explicit-edges: $(csv_edges_explicit)
$(csv_edges_explicit): $(rs_csv_folder_bind) $(edges_explicit_dir) $(edges_explicit_targets) | checkdirs
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(word 2, $^) $@
	@echo ''

implicit-edges: $(csv_edges_implicit)
$(csv_edges_implicit): $(rs_csv_folder_bind) $(edges_implicit_dir) $(edges_implicit_targets) | checkdirs
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(word 2, $^) $@
	@echo ''

## Create a CSV list containing all the edges found in the schema
all-edges: $(csv_edges)
$(csv_edges): $(rs_csv_folder_bind) $(edges_all_dir) $(csv_edges_explicit) $(csv_edges_implicit) | checkdirs
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(word 2, $^) $@
	@echo ''

