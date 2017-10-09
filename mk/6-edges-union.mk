
csv_edges_explicit := $(edges_dir)/explicit-edges.csv
csv_edges_implicit := $(edges_dir)/implicit-edges.csv
csv_edges := $(edges_dir)/edges.csv

# Build implicit edges from base-edge-list
edges-implicit: $(csv_edges_implicit)
$(csv_edges_explicit): $(rs_csv_bind) $(edges_explicit_targets) | conjeture
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo 'Created $@ --> OK.'
	@echo ''
	@echo $(sep)

# Build explicit edges from base-edge-list
edges-explicit: $(csv_edges_explicit)
$(csv_edges_implicit): $(rs_csv_bind) $(edges_implicit_targets) | conjeture
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo 'Created $@ --> OK.'
	@echo ''
	@echo $(sep)

## Build all edges (explicit and implitcit)
edges: $(csv_edges)
$(csv_edges): $(rs_csv_bind) $(csv_edges_explicit) $(csv_edges_summarized) $(csv_edges_implicit) | conjeture
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo 'Created $@ --> OK.'
	@echo ''
	@echo $(sep)








