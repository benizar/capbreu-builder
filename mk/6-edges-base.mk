
# RSCRIPTS
rs_base_edge_list := $(rs_edges_dir)/base-edge-list.R

# TARGETS
csv_base_edge_list := $(patsubst $(rs_edges_dir)/%.R,$(edges_dir)/%.csv,$(rs_base_edge_list))

# BASE EDGE LIST
$(csv_base_edge_list): $(rs_base_edge_list) $(csv_schema) $(csv_nodes) | conjeture
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo 'Created $@ --> OK.'
	@echo ''
	@echo $(sep)




