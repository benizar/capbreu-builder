
# DIRECTORY STRUCTURE (PATHS)
src_dir          := src
data_dir         := $(src_dir)/data
spatial_data_dir := $(data_dir)/spatial
rscripts_dir     := $(src_dir)/rscripts

builds_dir  := builds
#log_dir    := logs
#stamps_dir := stamps
#dirs       := $(builds_dir) $(log_dir) $(stamps_dir)
dirs        := $(builds_dir)

# Target for creating all necessary folders
checkdirs: $(dirs)
$(dirs):
	echo ''
	mkdir -p $@
	echo ''

# Data
spatial_data:= $(wildcard $(spatial_data_dir)/*.gml)
project_data:= $(wildcard $(data_dir)/capbreu_load_tests_flat.yml)

# RSCRIPTS
rs_landmetrics := $(rscripts_dir)/landmetrics.R
rs_levels := $(rscripts_dir)/levels.R

rs_bigtable := $(rscripts_dir)/bigtable.R
rs_bigtable_reshaped := $(rscripts_dir)/bigtable-reshaped.R

rs_landholders := $(rscripts_dir)/landholders.R
rs_neighbours := $(rscripts_dir)/neighbours.R
rs_level1 := $(rscripts_dir)/level1.R
rs_level2 := $(rscripts_dir)/level2.R

# Graph scripts
rs_graph_lh_l1 := $(rscripts_dir)/graph-lh-l1.R
rs_graph_lh_l2 := $(rscripts_dir)/graph-lh-l2.R
rs_graph_l1_l2 := $(rscripts_dir)/graph-l1-l2.R

# Plot scripts
rs_plot_lh_l1 := $(rscripts_dir)/plot-lh-l1.R
rs_plot_lh_l2 := $(rscripts_dir)/plot-lh-l2.R
rs_plot_l1_l2 := $(rscripts_dir)/plot-l1-l2.R


# TARGETS (One target per Rscript)
csv_landmetrics := $(patsubst $(rscripts_dir)/%.R,$(builds_dir)/%.csv,$(rs_landmetrics))
csv_levels := $(patsubst $(rscripts_dir)/%.R,$(builds_dir)/%.csv,$(rs_levels))

csv_bigtable := $(patsubst $(rscripts_dir)/%.R,$(builds_dir)/%.csv,$(rs_bigtable))
csv_bigtable_reshaped := $(patsubst $(rscripts_dir)/%.R,$(builds_dir)/%.csv,$(rs_bigtable_reshaped))

csv_landholders := $(patsubst $(rscripts_dir)/%.R,$(builds_dir)/%.csv,$(rs_landholders))
csv_neighbours := $(patsubst $(rscripts_dir)/%.R,$(builds_dir)/%.csv,$(rs_neighbours))
csv_level1 := $(patsubst $(rscripts_dir)/%.R,$(builds_dir)/%.csv,$(rs_level1))
csv_level2 := $(patsubst $(rscripts_dir)/%.R,$(builds_dir)/%.csv,$(rs_level2))

# Graphs
gv_graph_lh_l1 := $(patsubst $(rscripts_dir)/%.R,$(builds_dir)/%.gv,$(rs_graph_lh_l1))
gv_graph_lh_l2 := $(patsubst $(rscripts_dir)/%.R,$(builds_dir)/%.gv,$(rs_graph_lh_l2))
gv_graph_l1_l2 := $(patsubst $(rscripts_dir)/%.R,$(builds_dir)/%.gv,$(rs_graph_l1_l2))

html_plot_lh_l1 := $(patsubst $(rscripts_dir)/%.R,$(builds_dir)/%.html,$(rs_plot_lh_l1))
html_plot_lh_l2 := $(patsubst $(rscripts_dir)/%.R,$(builds_dir)/%.html,$(rs_plot_lh_l2))
html_plot_l1_l2 := $(patsubst $(rscripts_dir)/%.R,$(builds_dir)/%.html,$(rs_plot_l1_l2))

