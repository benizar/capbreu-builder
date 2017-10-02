
# Flipped table
rs_flipped   := $(rs_edges_dir)/flipped-edge-list.R
csv_flipped      := $(patsubst $(rs_edges_dir)/%.R,$(edges_dir)/%.csv,$(rs_flipped))

$(csv_flipped): $(rs_flipped) $(csv_base_edge_list) | conjeture
	@echo ''
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo ''

