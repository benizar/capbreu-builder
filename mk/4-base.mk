
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

endef



# Build rules foreach language, foreach template
$(foreach x,$(rs_base), \
	$(eval $(call build-base-rule,$(x))) \
)

## Builds base tables from source yaml
build-base: $(base_targets)

