
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


