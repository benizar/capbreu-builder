
# Base node list
rs_edges := $(rs_edges_dir)/edges.R
csv_edges := $(patsubst $(rs_edges_dir)/%.R,$(edges_dir)/%.csv,$(rs_edges))

# Merge all node files in one
edges-union: $(csv_edges)

builds/edges/edges.csv: $(rs_edges) $(edges_explicit_targets) $(edges_implicit_targets) | checkdirs
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo '...Created file $@. OK.'
