
# RSCRIPTS
rs_base_edge_list       := $(rscripts_edges_dir)/base-edge-list.R

# Explicit
rs_landholder_neighbour := $(rscripts_explicit_edges_dir)/landholder-neighbour.R
rs_landholder_level1    := $(rscripts_explicit_edges_dir)/landholder-level1.R
rs_landholder_level2    := $(rscripts_explicit_edges_dir)/landholder-level2.R

rs_plot_landholder      := $(rscripts_explicit_edges_dir)/plot-landholder.R
rs_plot_level1          := $(rscripts_explicit_edges_dir)/plot-level1.R
rs_plot_level2          := $(rscripts_explicit_edges_dir)/plot-level2.R
rs_plot_administrative  := $(rscripts_explicit_edges_dir)/plot-administrative.R
rs_plot_anthropic       := $(rscripts_explicit_edges_dir)/plot-anthropic.R
rs_plot_mountains         := $(rscripts_explicit_edges_dir)/plot-mountains.R
rs_plot_rivers         := $(rscripts_explicit_edges_dir)/plot-rivers.R

rs_level1_administrative  := $(rscripts_explicit_edges_dir)/level1-administrative.R
rs_level1_anthropic       := $(rscripts_explicit_edges_dir)/level1-anthropic.R
rs_level1_mountains         := $(rscripts_explicit_edges_dir)/level1-mountains.R
rs_level1_rivers         := $(rscripts_explicit_edges_dir)/level1-rivers.R

# Implicit
rs_flipped   := $(rscripts_implicit_edges_dir)/flipped-edge-list.R
rs_l1_l1     := $(rscripts_implicit_edges_dir)/l1-l1.R
rs_l2_l2     := $(rscripts_implicit_edges_dir)/l2-l2.R
rs_plot_plot_l1   := $(rscripts_implicit_edges_dir)/plot-plot-l1.R
rs_plot_plot_l2   := $(rscripts_implicit_edges_dir)/plot-plot-l2.R
rs_plot_plot_l3   := $(rscripts_implicit_edges_dir)/plot-plot-l3.R
rs_plot_plot := $(rscripts_implicit_edges_dir)/plot-plot.R

# All edges
rs_edges := $(rscripts_edges_dir)/edges.R



# TARGETS
csv_base_edge_list := $(patsubst $(rscripts_edges_dir)/%.R,$(edges_dir)/%.csv,$(rs_base_edge_list))

# Explicit
csv_landholder_neighbour := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(explicit_edges_dir)/%.csv,$(rs_landholder_neighbour))
csv_landholder_level1    := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(explicit_edges_dir)/%.csv,$(rs_landholder_level1))
csv_landholder_level2    := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(explicit_edges_dir)/%.csv,$(rs_landholder_level2))

csv_plot_landholder      := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(explicit_edges_dir)/%.csv,$(rs_plot_landholder))
csv_plot_level1          := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(explicit_edges_dir)/%.csv,$(rs_plot_level1))
csv_plot_level2          := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(explicit_edges_dir)/%.csv,$(rs_plot_level2))
csv_plot_administrative  := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(explicit_edges_dir)/%.csv,$(rs_plot_administrative))
csv_plot_anthropic       := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(explicit_edges_dir)/%.csv,$(rs_plot_anthropic))
csv_plot_mountains         := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(explicit_edges_dir)/%.csv,$(rs_plot_mountains))
csv_plot_rivers         := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(explicit_edges_dir)/%.csv,$(rs_plot_rivers))

csv_level1_administrative  := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(explicit_edges_dir)/%.csv,$(rs_level1_administrative))
csv_level1_anthropic       := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(explicit_edges_dir)/%.csv,$(rs_level1_anthropic))
csv_level1_mountains         := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(explicit_edges_dir)/%.csv,$(rs_level1_mountains))
csv_level1_rivers         := $(patsubst $(rscripts_explicit_edges_dir)/%.R,$(explicit_edges_dir)/%.csv,$(rs_level1_rivers))

# Implicit
csv_flipped      := $(patsubst $(rscripts_implicit_edges_dir)/%.R,$(implicit_edges_dir)/%.csv,$(rs_flipped))

csv_l1_l1        := $(patsubst $(rscripts_implicit_edges_dir)/%.R,$(implicit_edges_dir)/%.csv,$(rs_l1_l1))
csv_l2_l2        := $(patsubst $(rscripts_implicit_edges_dir)/%.R,$(implicit_edges_dir)/%.csv,$(rs_l2_l2))

csv_plot_plot_l1 := $(patsubst $(rscripts_implicit_edges_dir)/%.R,$(implicit_edges_dir)/%.csv,$(rs_plot_plot_l1))
csv_plot_plot_l2 := $(patsubst $(rscripts_implicit_edges_dir)/%.R,$(implicit_edges_dir)/%.csv,$(rs_plot_plot_l2))
csv_plot_plot_l3 := $(patsubst $(rscripts_implicit_edges_dir)/%.R,$(implicit_edges_dir)/%.csv,$(rs_plot_plot_l3))
csv_plot_plot    := $(patsubst $(rscripts_implicit_edges_dir)/%.R,$(implicit_edges_dir)/%.csv,$(rs_plot_plot))

# All edges
csv_edges := $(patsubst $(rscripts_edges_dir)/%.R,$(edges_dir)/%.csv,$(rs_edges))


