
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

dirs := $(base_dir) \
	$(nodes_dir) $(nodes_explicit_dir) $(nodes_summarized_dir) $(nodes_implicit_dir) $(nodes_all_dir) \
	$(edges_dir) $(edges_explicit_dir) $(edges_implicit_dir) $(edges_all_dir)

$(dirs):
	mkdir -p $@


# SOURCE DATA
data_dir         := data
spatial_data_dir := $(data_dir)/spatial
spatial_data     := $(wildcard $(spatial_data_dir)/*.gml)
input_data       := data/capbreu_full.yml

# WORKING DATA. Create hypothesis editing this file...
project_data := $(patsubst $(data_dir)/%.yml,$(builds_dir)/%.yml,$(input_data))


## Clean and create a new project structure
conjeture: $(clean) $(dirs)
	@echo 'Creating a new project...'
	@echo 'Copying your yaml schema to $(builds_dir)...'
	@cp $(input_data) $(project_data)
	@echo 'CREATE YOUR HYPOTHESIS BY EDITING THIS FILE: $(project_data)'
	@echo 'Your original schema will be preserved.'




