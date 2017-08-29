#-----------------------------
# DIRECTORY STRUCTURE (PATHS)
#-----------------------------
src_dir          := src
data_dir         := $(src)/data
spatial_data_dir := $(data_dir)/spatial

builds_dir  := builds
log_dir     := logs
stamps_dir  := stamps
dirs        := $(builds_dir) $(log_dir) $(stamps_dir)

# Target for creating all necessary folders
checkdirs: $(dirs)
$(dirs):
	mkdir -p $@


spatial_data:= $(wildcard $(src_dir)/*.gml)

