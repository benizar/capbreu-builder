
# Formatting

program := 'CABREVE CONJETURES BUILDER'
version := 0.0.1

sep:=-----------------------------------------------------

# RSCRIPT PATHS
rs_dir                  := rscripts

# Utility scripts
rs_csv_bind             := $(rs_dir)/csv_bind.R

# Base scripts
rs_base_dir             := $(rs_dir)/base

# Node scripts
rs_nodes_dir            := $(rs_dir)/nodes
rs_nodes_explicit_dir   := $(rs_nodes_dir)/explicit
rs_nodes_summarized_dir := $(rs_nodes_dir)/summarized
rs_nodes_implicit_dir   := $(rs_nodes_dir)/implicit

# Edge scripts
rs_edges_dir            := $(rs_dir)/edges
rs_edges_explicit_dir   := $(rs_edges_dir)/explicit
rs_edges_implicit_dir   := $(rs_edges_dir)/implicit

# Graphs
rs_graphs_dir           := $(rs_dir)/graphs
rs_igraphs_dir          := $(rs_graphs_dir)/igraphs
rs_visnetworks_dir      := $(rs_graphs_dir)/visnetworks


# BUILD PATHS
builds_dir              := builds
base_dir                := $(builds_dir)/base

nodes_dir               := $(builds_dir)/nodes
nodes_explicit_dir      := $(nodes_dir)/explicit
nodes_summarized_dir    := $(nodes_dir)/summarized
nodes_implicit_dir      := $(nodes_dir)/implicit

edges_dir               := $(builds_dir)/edges
edges_implicit_dir      := $(edges_dir)/implicit
edges_explicit_dir      := $(edges_dir)/explicit

graphs_dir              := $(builds_dir)/graphs
igraphs_dir             := $(graphs_dir)/igraphs
visnetworks_dir          := $(graphs_dir)/visnetworks


dirs := $(base_dir) \
	$(nodes_dir) $(nodes_explicit_dir) $(nodes_summarized_dir) $(nodes_implicit_dir) $(nodes_all_dir) \
	$(edges_dir) $(edges_explicit_dir) $(edges_implicit_dir) $(edges_all_dir) \
	$(graphs_dir) $(igraphs_dir) $(visnetworks_dir)

$(dirs):
	mkdir -p $@


# SOURCE DATA
data_dir         := data
spatial_data_dir := $(data_dir)/spatial
spatial_data     := $(wildcard $(spatial_data_dir)/*.gml)
input_data       := $(wildcard data/capbreu_full.yml)

# WORKING DATA. Create hypothesis editing this file...
project_data := $(patsubst $(data_dir)/%.yml,$(builds_dir)/%.yml,$(input_data))

## Create a new project structure
conjeture: $(dirs)


$(project_data): $(input_data) | conjeture
	@echo 'Creating a working copy or $<...'
	@cp $< $@
	@echo 'Created $@ --> OK.'
	@echo ''
	@echo $(sep)


