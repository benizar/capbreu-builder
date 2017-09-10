include mk/*.mk

## Create all files and outputs from the begining
all: clean

## Write graph.html (vis.js interactive) using visNetwork
build-plots: $(html_plot_lh_l1) $(html_plot_lh_l2) $(html_plot_l1_l2)
$(html_plot_lh_l1): $(rs_plot_lh_l1) $(gv_graph_lh_l1)
$(html_plot_lh_l2): $(rs_plot_lh_l2) $(gv_graph_lh_l2)
$(html_plot_l1_l2): $(rs_plot_l1_l2) $(gv_graph_l1_l2)

## Write this Graphviz DOT using iGraph
build-graphs: $(gv_graph_lh_l1) $(gv_graph_lh_l2) $(gv_graph_l1_l2)
$(gv_graph_lh_l1): $(rs_graph_lh_l1) $(csv_bigtable_reshaped) $(csv_landholders) $(csv_level1)
$(gv_graph_lh_l2): $(rs_graph_lh_l2) $(csv_bigtable_reshaped) $(csv_landholders) $(csv_level2)
$(gv_graph_l1_l2): $(rs_graph_l1_l2) $(csv_bigtable_reshaped) $(csv_level1) $(csv_level2)

# Landholders
$(csv_landholders): $(rs_landholders) $(csv_bigtable_reshaped)

# Neighbours
$(csv_neighbours): $(rs_neighbours) $(csv_bigtable) $(csv_landholders)

# Level1
$(csv_level1): $(rs_level1) $(csv_bigtable_reshaped)

# Level2
$(csv_level2): $(rs_level2) $(csv_bigtable_reshaped)

# Write a reshaped big table
$(csv_bigtable_reshaped): $(rs_bigtable_reshaped) $(csv_bigtable)

# Write the big table
$(csv_bigtable): $(rs_bigtable) $(project_data)

# Landmetrics
$(csv_landmetrics): $(rs_landmetrics) $(project_data)

# Levels
$(csv_levels): $(rs_levels) $(project_data)

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
$(builds_dir)/%.gv: $(rscripts_dir)/%.R | checkdirs
	@echo ''
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo ''

# Patern rule for Rscripts--arguments->csv
$(builds_dir)/%.csv: $(rscripts_dir)/%.R | checkdirs
	@echo ''
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(filter-out $<, $^) $@
	@echo ''


.PHONY: clean
## Clean project
clean: | checkdirs
	@echo ''
	@echo 'Cleaning project ...'
	$(RM) $(builds_dir)/*
	@echo ''

