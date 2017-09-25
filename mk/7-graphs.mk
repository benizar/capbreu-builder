
# scripts
rs_graph_full := $(rscripts_graphs_dir)/graph-full.R

# Graphs
gv_graph_full := $(patsubst $(rscripts_graphs_dir)/%.R,$(builds_dir)/%.gv,$(rs_graph_full))


