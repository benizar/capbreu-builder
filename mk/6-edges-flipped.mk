
# Flipped table
rs_flipped   := $(rs_edges_implicit_dir)/flipped-edge-list.R
csv_flipped      := $(patsubst $(rs_edges_implicit_dir)/%.R,$(edges_implicit_dir)/%.csv,$(rs_flipped))

$(csv_flipped): $(rs_flipped) $(csv_base_edge_list) | checkdirs
	@echo ''
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo ''

