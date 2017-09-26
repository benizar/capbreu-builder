
# RScripts
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

# Targets
csv_base_node_list := $(patsubst $(rscripts_nodes_dir)/%.R,$(nodes_dir)/%.csv,$(rs_base_node_list))
csv_administrative := $(patsubst $(rscripts_nodes_dir)/%.R,$(nodes_dir)/%.csv,$(rs_administrative))
csv_anthropic      := $(patsubst $(rscripts_nodes_dir)/%.R,$(nodes_dir)/%.csv,$(rs_anthropic))
csv_landholders    := $(patsubst $(rscripts_nodes_dir)/%.R,$(nodes_dir)/%.csv,$(rs_landholders))
csv_level1         := $(patsubst $(rscripts_nodes_dir)/%.R,$(nodes_dir)/%.csv,$(rs_level1))
csv_level2         := $(patsubst $(rscripts_nodes_dir)/%.R,$(nodes_dir)/%.csv,$(rs_level2))
csv_natural        := $(patsubst $(rscripts_nodes_dir)/%.R,$(nodes_dir)/%.csv,$(rs_natural))
csv_neighbours     := $(patsubst $(rscripts_nodes_dir)/%.R,$(nodes_dir)/%.csv,$(rs_neighbours))
csv_plots          := $(patsubst $(rscripts_nodes_dir)/%.R,$(nodes_dir)/%.csv,$(rs_plots))
csv_nodes          := $(patsubst $(rscripts_nodes_dir)/%.R,$(nodes_dir)/%.csv,$(rs_nodes))



