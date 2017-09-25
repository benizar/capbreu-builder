
# DIRECTORY STRUCTURE (PATHS)
src_dir          := src
data_dir         := $(src_dir)/data
spatial_data_dir := $(data_dir)/spatial


rscripts_dir                := $(src_dir)/rscripts
rscripts_base_dir           := $(rscripts_dir)/base
rscripts_nodes_dir          := $(rscripts_base_dir)/nodes
rscripts_edges_dir          := $(rscripts_base_dir)/edges
rscripts_explicit_edges_dir := $(rscripts_edges_dir)/explicit
rscripts_implicit_edges_dir := $(rscripts_edges_dir)/implicit

rscripts_graphs_dir := $(rscripts_base_dir)/graphs
rscripts_viz_dir    := $(rscripts_base_dir)/viz


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

# SOURCE DATA
spatial_data := $(wildcard $(spatial_data_dir)/*.gml)
project_data := $(wildcard $(data_dir)/capbreu_full.yml)

# RSCRIPTS
# Base
rs_context_df := $(rscripts_base_dir)/context-df.R
rs_proj_df    := $(rscripts_base_dir)/proj-df.R
rs_schema_df  := $(rscripts_base_dir)/schema-df.R

# Nodes
rs_base_node_list := $(rscripts_nodes_dir)/base-node-list.R
rs_administrative := $(rscripts_nodes_dir)/administrative.R
rs_anthropic      := $(rscripts_nodes_dir)/anthropic.R
rs_landholders    := $(rscripts_nodes_dir)/landholders.R
rs_level1         := $(rscripts_nodes_dir)/level1.R
rs_level2         := $(rscripts_nodes_dir)/level2.R
rs_natural        := $(rscripts_nodes_dir)/natural.R
rs_neighbours     := $(rscripts_nodes_dir)/neighbours.R
rs_plots          := $(rscripts_nodes_dir)/plots.R
rs_nodes          := $(rscripts_nodes_dir)/nodes.R

# Explicit Edges
rs_base_edge_list       := $(rscripts_edges_dir)/base-edge-list.R
rs_landholder_level1    := $(rscripts_explicit_edges_dir)/landholder-level1.R
rs_landholder_level2    := $(rscripts_explicit_edges_dir)/landholder-level2.R
rs_landholder_neighbour := $(rscripts_explicit_edges_dir)/landholder-neighbour.R
rs_plot_administrative  := $(rscripts_explicit_edges_dir)/plot-administrative.R
rs_plot_anthropic       := $(rscripts_explicit_edges_dir)/plot-anthropic.R
rs_plot_level1          := $(rscripts_explicit_edges_dir)/plot-level1.R
rs_plot_level2          := $(rscripts_explicit_edges_dir)/plot-level2.R
rs_plot_natural         := $(rscripts_explicit_edges_dir)/plot-natural.R

# Implicit Edges
rs_flipped   := $(rscripts_implicit_edges_dir)/flipped-base-edge-list.R
rs_l1_l1     := $(rscripts_implicit_edges_dir)/l1-l1.R
rs_l2_l2     := $(rscripts_implicit_edges_dir)/l2-l2.R
rs_plot_l1   := $(rscripts_implicit_edges_dir)/plot-l1.R
rs_plot_l2   := $(rscripts_implicit_edges_dir)/plot-l2.R
rs_plot_l3   := $(rscripts_implicit_edges_dir)/plot-l3.R
rs_plot_plot := $(rscripts_implicit_edges_dir)/plot-plot.R

# Edges
rs_edges := $(rscripts_edges_dir)/edges.R




# TARGETS (One target per Rscript)
# Base targets
csv_context_df := $(patsubst $(rscripts_base_dir)/%.R,$(builds_dir)/%.csv,$(rs_context_df))
csv_proj_df    := $(patsubst $(rscripts_base_dir)/%.R,$(builds_dir)/%.csv,$(rs_proj_df))
csv_schema_df  := $(patsubst $(rscripts_base_dir)/%.R,$(builds_dir)/%.csv,$(rs_schema_df))

# Nodes targets
csv_base_node_list := $(patsubst $(rscripts_nodes_dir)/%.R,$(builds_dir)/%.csv,$(rs_base_node_list))
csv_administrative := $(patsubst $(rscripts_nodes_dir)/%.R,$(builds_dir)/%.csv,$(rs_administrative))
csv_anthropic      := $(patsubst $(rscripts_nodes_dir)/%.R,$(builds_dir)/%.csv,$(rs_anthropic))
csv_landholders    := $(patsubst $(rscripts_nodes_dir)/%.R,$(builds_dir)/%.csv,$(rs_landholders))
csv_level1         := $(patsubst $(rscripts_nodes_dir)/%.R,$(builds_dir)/%.csv,$(rs_level1))
csv_level2         := $(patsubst $(rscripts_nodes_dir)/%.R,$(builds_dir)/%.csv,$(rs_level2))
csv_natural        := $(patsubst $(rscripts_nodes_dir)/%.R,$(builds_dir)/%.csv,$(rs_natural))
csv_neighbours     := $(patsubst $(rscripts_nodes_dir)/%.R,$(builds_dir)/%.csv,$(rs_neighbours))
csv_plots          := $(patsubst $(rscripts_nodes_dir)/%.R,$(builds_dir)/%.csv,$(rs_plots))
csv_nodes          := $(patsubst $(rscripts_nodes_dir)/%.R,$(builds_dir)/%.csv,$(rs_nodes))

# Edges
csv_base_edge_list := $(patsubst $(rscripts_edges_dir)/%.R,$(builds_dir)/%.csv,$(rs_base_edge_list))

# Explicit relationships
csv_landholder_level1    := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(builds_dir)/%.csv,$(rs_landholder_level1))
csv_landholder_level2    := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(builds_dir)/%.csv,$(rs_landholder_level2))
csv_landholder_neighbour := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(builds_dir)/%.csv,$(rs_landholder_neighbour))
csv_plot_administrative  := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(builds_dir)/%.csv,$(rs_plot_administrative))
csv_plot_anthropic       := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(builds_dir)/%.csv,$(rs_plot_anthropic))
csv_plot_level1          := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(builds_dir)/%.csv,$(rs_plot_level1))
csv_plot_level2          := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(builds_dir)/%.csv,$(rs_plot_level2))
csv_plot_natural         := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(builds_dir)/%.csv,$(rs_plot_natural))

# Implicit relationships
csv_flipped   := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(builds_dir)/%.csv,$(rs_flipped))
csv_l1_l1     := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(builds_dir)/%.csv,$(rs_l1_l1))
csv_l2_l2     := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(builds_dir)/%.csv,$(rs_l2_l2))
csv_plot_l1   := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(builds_dir)/%.csv,$(rs_plot_l1))
csv_plot_l2   := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(builds_dir)/%.csv,$(rs_plot_l2))
csv_plot_l3   := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(builds_dir)/%.csv,$(rs_plot_l3))
csv_plot_plot := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(builds_dir)/%.csv,$(rs_plot_plot))

# All edges
csv_edges := $(patsubst $(rscripts_edges_dir)/%.R,$(builds_dir)/%.csv,$(rs_edges))



#################
# Graph scripts
rs_graph_lh_l1 := $(rscripts_dir)/graph-lh-l1.R
rs_graph_lh_l2 := $(rscripts_dir)/graph-lh-l2.R
rs_graph_l1_l2 := $(rscripts_dir)/graph-l1-l2.R

# Plot scripts
rs_plot_lh_l1 := $(rscripts_dir)/plot-lh-l1.R
rs_plot_lh_l2 := $(rscripts_dir)/plot-lh-l2.R
rs_plot_l1_l2 := $(rscripts_dir)/plot-l1-l2.R
#################

# Graphs
gv_graph_lh_l1 := $(patsubst $(rscripts_dir)/%.R,$(builds_dir)/%.gv,$(rs_graph_lh_l1))
gv_graph_lh_l2 := $(patsubst $(rscripts_dir)/%.R,$(builds_dir)/%.gv,$(rs_graph_lh_l2))
gv_graph_l1_l2 := $(patsubst $(rscripts_dir)/%.R,$(builds_dir)/%.gv,$(rs_graph_l1_l2))

html_plot_lh_l1 := $(patsubst $(rscripts_dir)/%.R,$(builds_dir)/%.html,$(rs_plot_lh_l1))
html_plot_lh_l2 := $(patsubst $(rscripts_dir)/%.R,$(builds_dir)/%.html,$(rs_plot_lh_l2))
html_plot_l1_l2 := $(patsubst $(rscripts_dir)/%.R,$(builds_dir)/%.html,$(rs_plot_l1_l2))

