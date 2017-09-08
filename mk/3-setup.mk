
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
rs_write_bigTable := $(rscripts_dir)/write-bigtable.R
rs_write_bigTable_reshaped := $(rscripts_dir)/write-bigtable-reshaped.R

