
# rs
rs_base := $(wildcard $(rs_base_dir)/*.R)

#-------------
# BUILD RULES
#-------------
define build-base-rule
$(base_dir)/$(basename $(notdir $1)).csv: $1 $(project_data) | checkdirs
	@echo ''
	@echo 'Runing Rscript $$(<F)...'
	@$(RUN_RSCRIPT) $$< $$(filter-out $$<, $$^) $$@
	@echo 'Created $$@ --> OK.'

base_targets+= $(base_dir)/$(basename $(notdir $1)).csv

# Automatically create base variables, necessary in other rules.
# TODO: Define what should we do if these variables are not created
ifneq (,$(findstring schema,$1))
    # Found
csv_schema=$(base_dir)/$(basename $(notdir $1)).csv
else
    # Not found
endif

ifneq (,$(findstring context,$1))
    # Found
csv_context=$(base_dir)/$(basename $(notdir $1)).csv
else
    # Not found
endif

ifneq (,$(findstring project,$1))
    # Found
csv_project=$(base_dir)/$(basename $(notdir $1)).csv
else
    # Not found
endif


endef


# Build rules foreach language, foreach template
$(foreach x,$(rs_base), \
	$(eval $(call build-base-rule,$(x))) \
)

## Builds base tables from source yaml
build-base: $(base_targets)

