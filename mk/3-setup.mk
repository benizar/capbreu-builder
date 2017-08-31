
# DIRECTORY STRUCTURE (PATHS)
src_dir          := src
data_dir         := $(src_dir)/data
spatial_data_dir := $(data_dir)/spatial
rscripts_dir     := $(src_dir)/rscripts

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

# Data
spatial_data:= $(wildcard $(spatial_data_dir)/*.gml)
project_data:= $(wildcard $(data_dir)/capbreu_load_tests_flat.yml)

# Rscripts
rs_write_big_table := $(rscripts_dir)/big-table.R
rs_write_landholders_list := $(rscripts_dir)/landholders-list.R

rs_plot_area_per_l2 := $(rscripts_dir)/area-per-l2-plot.R

# Lists
rs_csv:= $(rs_write_big_table) \
	$(rs_write_landholders_list)

rs_pdf:= $(rs_plot_area_per_l2)

# Targets
rs_csv_targets:= $(patsubst $(rscripts_dir)/%.R,$(builds_dir)/%.csv,$(rs_csv))
rs_pdf_targets:= $(patsubst $(rscripts_dir)/%.R,$(builds_dir)/%.pdf,$(rs_pdf))

