

# DIRECTORY STRUCTURE (PATHS)
src_dir          := src
data_dir         := $(src_dir)/data
spatial_data_dir := $(data_dir)/spatial


rscripts_dir                := $(src_dir)/rscripts
rscripts_base_dir           := $(rscripts_dir)/base
rscripts_nodes_dir          := $(rscripts_dir)/nodes
rscripts_edges_dir          := $(rscripts_dir)/edges
rscripts_explicit_edges_dir := $(rscripts_edges_dir)/explicit
rscripts_implicit_edges_dir := $(rscripts_edges_dir)/implicit

rscripts_graphs_dir := $(rscripts_dir)/graphs
rscripts_viz_dir    := $(rscripts_dir)/viz


builds_dir  := builds
base_dir  := $(builds_dir)/base
nodes_dir  := $(builds_dir)/nodes
edges_dir  := $(builds_dir)/edges
implicit_edges_dir  := $(edges_dir)/implicit
explicit_edges_dir  := $(edges_dir)/explicit
#log_dir    := logs
#stamps_dir := stamps
#dirs       := $(builds_dir) $(log_dir) $(stamps_dir)
dirs        := $(base_dir) $(nodes_dir) $(implicit_edges_dir) $(explicit_edges_dir)

# Target for creating all necessary folders
checkdirs: $(dirs)
$(dirs):
	@echo 'Need to create some folders before starting...'
	mkdir -p $@

# SOURCE DATA
spatial_data := $(wildcard $(spatial_data_dir)/*.gml)
project_data := $(wildcard $(data_dir)/capbreu_full.yml)


#TODO: work with a copy of the original file, so the user can edit and experiment
d:$(project_data)

# Target for creating all necessary folders
$(builds_dir)/%.yml: $(data_dir)/%.yml
	@echo 'Copying $< to $@...'
	mv $< $@
