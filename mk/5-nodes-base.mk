
# Base node list
rs_base_node_list := $(rs_nodes_dir)/base-node-list.R
csv_base_node_list := $(patsubst $(rs_nodes_dir)/%.R,$(nodes_dir)/%.csv,$(rs_base_node_list))

$(csv_base_node_list): $(rs_base_node_list) $(csv_schema) $(csv_context)
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo ''


