
# RSCRIPTS
rs_context := $(rscripts_base_dir)/context.R
rs_proj    := $(rscripts_base_dir)/proj.R
rs_schema  := $(rscripts_base_dir)/schema.R


# TARGETS
csv_context := $(patsubst $(rscripts_base_dir)/%.R,$(builds_dir)/%.csv,$(rs_context))
csv_proj    := $(patsubst $(rscripts_base_dir)/%.R,$(builds_dir)/%.csv,$(rs_proj))
csv_schema  := $(patsubst $(rscripts_base_dir)/%.R,$(builds_dir)/%.csv,$(rs_schema))


