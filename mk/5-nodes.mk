
# rs
rs_base_node_list := $(rs_nodes_dir)/base-node-list.R
csv_base_node_list := $(patsubst $(rs_nodes_dir)/%.R,$(nodes_dir)/%.csv,$(rs_base_node_list))

$(csv_base_node_list): $(rs_base_node_list) $(csv_schema) $(csv_context)
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo ''


rs_administrative := $(rs_nodes_dir)/administrative.R
rs_anthropic      := $(rs_nodes_dir)/anthropic.R
rs_mountains        := $(rs_nodes_dir)/mountains.R
rs_rivers        := $(rs_nodes_dir)/rivers.R

rs_landholders    := $(rs_nodes_dir)/landholders.R
rs_level1         := $(rs_nodes_dir)/level1.R
rs_level2         := $(rs_nodes_dir)/level2.R

rs_neighbours     := $(rs_nodes_dir)/neighbours.R
rs_plots          := $(rs_nodes_dir)/plots.R

rs_nodes          := $(rs_nodes_dir)/nodes.R

# Targets

csv_administrative := $(patsubst $(rs_nodes_dir)/%.R,$(nodes_dir)/%.csv,$(rs_administrative))
csv_anthropic      := $(patsubst $(rs_nodes_dir)/%.R,$(nodes_dir)/%.csv,$(rs_anthropic))
csv_landholders    := $(patsubst $(rs_nodes_dir)/%.R,$(nodes_dir)/%.csv,$(rs_landholders))
csv_level1         := $(patsubst $(rs_nodes_dir)/%.R,$(nodes_dir)/%.csv,$(rs_level1))
csv_level2         := $(patsubst $(rs_nodes_dir)/%.R,$(nodes_dir)/%.csv,$(rs_level2))
csv_mountains        := $(patsubst $(rs_nodes_dir)/%.R,$(nodes_dir)/%.csv,$(rs_mountains))
csv_rivers        := $(patsubst $(rs_nodes_dir)/%.R,$(nodes_dir)/%.csv,$(rs_rivers))
csv_neighbours     := $(patsubst $(rs_nodes_dir)/%.R,$(nodes_dir)/%.csv,$(rs_neighbours))
csv_plots          := $(patsubst $(rs_nodes_dir)/%.R,$(nodes_dir)/%.csv,$(rs_plots))
csv_nodes          := $(patsubst $(rs_nodes_dir)/%.R,$(nodes_dir)/%.csv,$(rs_nodes))


## Build all nodes
nodes: $(csv_nodes)



$(csv_administrative): $(rs_administrative) $(csv_schema)
$(csv_anthropic):      $(rs_anthropic)      $(csv_schema)
$(csv_mountains):      $(rs_mountains)      $(csv_schema)
$(csv_rivers):         $(rs_rivers)         $(csv_schema)

$(csv_landholders):    $(rs_landholders)    $(csv_base_node_list)
$(csv_level1):         $(rs_level1)         $(csv_base_node_list)
$(csv_level2):         $(rs_level2)         $(csv_base_node_list)

$(csv_neighbours):     $(rs_neighbours)     $(csv_schema)         $(csv_landholders)
$(csv_plots):          $(rs_plots)          $(csv_base_node_list)

$(csv_nodes): $(rs_nodes) \
		$(csv_administrative) $(csv_anthropic) $(csv_mountains) $(csv_rivers) \
		$(csv_landholders) $(csv_level1) $(csv_level2)  \
		$(csv_neighbours) $(csv_plots)


# Patern rule for rs--arguments->csv
$(nodes_dir)/%.csv: $(rs_nodes_dir)/%.R | checkdirs
	@echo ''
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo ''


