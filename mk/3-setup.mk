
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
visnetworks_dir         := $(graphs_dir)/visnetworks

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
background_image := $(wildcard data/poblet-relleu.png)
input_data       := $(wildcard data/tagarina.yml)

# WORKING DATA. Create new conjetures by editing this file...
project_data       := $(patsubst $(data_dir)/%.yml,$(builds_dir)/%.yml,$(input_data))
project_background := $(patsubst $(data_dir)/%.png,$(builds_dir)/%.png,$(background_image))

$(project_data): $(input_data)
	@echo ''
	@echo 'Creating a working copy of $<...'
	@cp $< $@
	@echo 'Created $@ --> OK.'
	@echo ''
	@echo $(sep)

$(project_background): $(background_image)
	@echo ''
	@echo 'Creating a working copy of $<...'
	@cp $< $@
	@echo 'Created $@ --> OK.'
	@echo ''
	@echo $(sep)


# INSTALL like dirs. Only need to create these if the user wants to.
outputs_dir             := outputs
disproofs_dir           := $(outputs_dir)/disproofs
undecidables_dir        := $(outputs_dir)/undecidables
hypotheses_dir          := $(outputs_dir)/hypotheses
proofs_dir              := $(outputs_dir)/proofs


$(disproofs_dir): $(builds_dir)
	mkdir -p $@
	@mv $< $@/conjeture-$(shell date +%Y%m%d_%H%M%S)

$(undecidables_dir): $(builds_dir)
	mkdir -p $@
	@mv $< $@/conjeture-$(shell date +%Y%m%d_%H%M%S)

$(hypotheses_dir): $(builds_dir)
	mkdir -p $@
	@mv $< $@/conjeture-$(shell date +%Y%m%d_%H%M%S)

$(proofs_dir): $(builds_dir)
	mkdir -p $@
	@mv $< $@/conjeture-$(shell date +%Y%m%d_%H%M%S)



