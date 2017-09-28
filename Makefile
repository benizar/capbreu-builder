include mk/*.mk


## Create all files and outputs from the begining
all: nodes edges

# Base rules
$(csv_proj):    $(rs_proj)    $(project_data)
$(csv_context): $(rs_context) $(project_data)
$(csv_schema):  $(rs_schema)  $(project_data)

## Build all nodes
nodes: $(csv_nodes)

$(csv_base_node_list): $(rs_base_node_list) $(csv_schema) $(csv_context)

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

## Build all edges
edges: $(csv_edges)

$(csv_base_edge_list): $(rs_base_edge_list) $(csv_schema) $(csv_nodes)

# Explicit
$(csv_landholder_neighbour): $(rs_landholder_neighbour) $(csv_base_edge_list)
$(csv_landholder_level1):    $(rs_landholder_level1)    $(csv_base_edge_list)
$(csv_landholder_level2):    $(rs_landholder_level2)    $(csv_base_edge_list)

$(csv_plot_landholder):     $(rs_plot_landholder)     $(csv_base_edge_list)
$(csv_plot_level1):         $(rs_plot_level1)         $(csv_base_edge_list)
$(csv_plot_level2):         $(rs_plot_level2)         $(csv_base_edge_list)
$(csv_plot_administrative): $(rs_plot_administrative) $(csv_base_edge_list)
$(csv_plot_anthropic):      $(rs_plot_anthropic)      $(csv_base_edge_list)
$(csv_plot_mountains):      $(rs_plot_mountains)      $(csv_base_edge_list)
$(csv_plot_rivers):         $(rs_plot_rivers)         $(csv_base_edge_list)

$(csv_level1_administrative): $(rs_level1_administrative) $(csv_base_edge_list)
$(csv_level1_anthropic):      $(rs_level1_anthropic)      $(csv_base_edge_list)
$(csv_level1_mountains):      $(rs_level1_mountains)      $(csv_base_edge_list)
$(csv_level1_rivers):         $(rs_level1_rivers)         $(csv_base_edge_list)

# Implicit
$(csv_flipped): $(rs_flipped) $(csv_base_edge_list)

$(csv_level1_level1): $(rs_level1_level1) $(csv_base_edge_list) $(csv_flipped)
$(csv_level2_level2): $(rs_level2_level2) $(csv_base_edge_list) $(csv_flipped)

$(csv_plot_plot_l1): $(rs_plot_plot_l1) $(csv_base_edge_list) $(csv_flipped)
$(csv_plot_plot_l2): $(rs_plot_plot_l2) $(csv_base_edge_list) $(csv_flipped) 
$(csv_plot_plot_l3): $(rs_plot_plot_l3) $(csv_base_edge_list) $(csv_flipped) 
$(csv_plot_plot):    $(rs_plot_plot)  \
			$(csv_plot_plot_l1) $(csv_plot_plot_l2) $(csv_plot_plot_l3)

# All edges
$(csv_edges): $(rs_edges) \
		$(csv_landholder_neighbour) \
		$(csv_landholder_level1) $(csv_landholder_level2) \
		$(csv_plot_landholder) $(csv_plot_level1) $(csv_plot_level2) \
		$(csv_plot_administrative) $(csv_plot_anthropic) $(csv_plot_mountains) $(csv_plot_rivers) \
		$(csv_level1_administrative) $(csv_level1_anthropic) $(csv_level1_mountains) $(csv_level1_rivers) \
		$(csv_level1_level1) $(csv_level2_level2) \
		$(csv_plot_plot)


graphs: $(gv_graph_full)

$(gv_graph_full): $(rs_graph_full) $(csv_nodes) $(csv_edges)

#---------------
# PATTERN RULES
#---------------
# Patern rule for Rscripts--arguments->html (visNetwork interactive)
$(builds_dir)/%.html: $(rscripts_dir)/%.R | checkdirs
	@echo ''
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $(@F)
	@mv $(@F) $@
	@echo ''

# Patern rule for Rscripts--arguments->gv (Graphviz DOT)
$(builds_dir)/%.gv: $(rscripts_graphs_dir)/%.R | checkdirs
	@echo ''
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo ''





# Patern rule for Rscripts--arguments->csv
$(edges_dir)/%.csv: $(rscripts_edges_dir)/%.R | checkdirs
	@echo ''
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo ''

# Patern rule for Rscripts--arguments->csv
$(explicit_edges_dir)/%.csv: $(rscripts_explicit_edges_dir)/%.R | checkdirs
	@echo ''
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo ''

# Patern rule for Rscripts--arguments->csv
$(implicit_edges_dir)/%.csv: $(rscripts_implicit_edges_dir)/%.R | checkdirs
	@echo ''
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo ''

# Patern rule for Rscripts--arguments->csv
$(nodes_dir)/%.csv: $(rscripts_nodes_dir)/%.R | checkdirs
	@echo ''
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo ''

# Patern rule for Rscripts--arguments->csv
$(base_dir)/%.csv: $(rscripts_base_dir)/%.R | checkdirs
	@echo ''
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo 'Created $@ --> OK.'



.PHONY: clean
## Clean project
clean: | checkdirs
	@echo ''
	@echo 'Cleaning project ...'
	@$(RM) -rf $(builds_dir)
	@echo 'Removed everything that was created using this Makefile.'
	@echo ''

