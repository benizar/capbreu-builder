
csv_edges_explicit := $(edges_dir)/explicit-edges.csv
csv_edges_implicit := $(edges_dir)/implicit-edges.csv
csv_edges := $(edges_dir)/edges.csv

explicit-edges: $(csv_edges_explicit)
$(csv_edges_explicit): $(rs_csv_bind) $(edges_explicit_targets) | checkdirs
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo ''

implicit-edges: $(csv_edges_implicit)
$(csv_edges_implicit): $(rs_csv_bind) $(edges_implicit_targets) | checkdirs
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo ''

## Create a CSV list containing all the edges found in the schema
edges: $(csv_edges)
$(csv_edges): $(rs_csv_bind) $(csv_edges_explicit) $(csv_edges_summarized) $(csv_edges_implicit) | checkdirs
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo ''


