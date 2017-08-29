#-----------------------------
# DIRECTORY STRUCTURE (PATHS)
#-----------------------------
src_dir          := src
data_dir         := $(src_dir)/data
spatial_data_dir := $(data_dir)/spatial
rscripts_dir     := $(src_dir)/rscripts

builds_dir  := builds
log_dir     := logs
stamps_dir  := stamps
dirs        := $(builds_dir) $(log_dir) $(stamps_dir)

# Target for creating all necessary folders
checkdirs: $(dirs)
$(dirs):
	mkdir -p $@


spatial_data:= $(wildcard $(spatial_data_dir)/*.gml)
data:= $(wildcard $(data_dir)/*.yml)

