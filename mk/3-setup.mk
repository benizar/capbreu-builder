

# DIRECTORY STRUCTURE (PATHS)
src_dir          := src
data_dir         := $(src_dir)/data
spatial_data_dir := $(data_dir)/spatial

# rscripts
rs_dir                  := $(src_dir)/rscripts
rs_base_dir             := $(rs_dir)/base

rs_nodes_dir            := $(rs_dir)/nodes
rs_nodes_explicit_dir   := $(rs_nodes_dir)/explicit
rs_nodes_summarized_dir := $(rs_nodes_dir)/summarized
rs_nodes_implicit_dir   := $(rs_nodes_dir)/implicit
rs_nodes_all_dir        := $(rs_nodes_dir)/all

rs_edges_dir          := $(rs_dir)/edges
rs_edges_explicit_dir := $(rs_edges_dir)/explicit
rs_edges_implicit_dir := $(rs_edges_dir)/implicit
rs_edges_all_dir      := $(rs_edges_dir)/all

# builds
builds_dir  := builds
base_dir  := $(builds_dir)/base

nodes_dir            := $(builds_dir)/nodes
nodes_explicit_dir   := $(nodes_dir)/explicit
nodes_summarized_dir := $(nodes_dir)/summarized
nodes_implicit_dir   := $(nodes_dir)/implicit
nodes_all_dir        := $(nodes_dir)/all

edges_dir          := $(builds_dir)/edges
edges_implicit_dir := $(edges_dir)/implicit
edges_explicit_dir := $(edges_dir)/explicit
edges_all_dir      := $(edges_dir)/all


#log_dir    := logs
#stamps_dir := stamps
#dirs       := $(builds_dir) $(log_dir) $(stamps_dir)

dirs := $(base_dir) \
	$(nodes_dir) $(nodes_explicit_dir) $(nodes_summarized_dir) $(nodes_implicit_dir) $(nodes_all_dir) \
	$(edges_dir) $(edges_explicit_dir) $(edges_implicit_dir) $(edges_all_dir)

# Target for creating all necessary folders
checkdirs: $(dirs)
$(dirs):
	@echo 'Need to create some folders before starting...'
	mkdir -p $@

# SOURCE DATA
spatial_data := $(wildcard $(spatial_data_dir)/*.gml)
project_data := $(wildcard $(data_dir)/capbreu_full.yml)

# Global scripts
rs_csv_folder_bind := $(rs_dir)/csv_folder_bind.R

