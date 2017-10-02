
# For now only neighbours.R, need schema.csv + landholders.csv (summarized)
rs_nodes_implicit   := $(wildcard $(rs_nodes_implicit_dir)/*.R)

# BUILD RULES
define build-nodes-implicit-rule
$(nodes_implicit_dir)/$(basename $(notdir $1)).csv: $1 $(csv_schema) $(csv_landholders) | conjeture
	@echo ''
	@echo 'Runing Rscript $$(<F)...'
	@$(RUN_RSCRIPT) $$< $$(filter-out $$<, $$^) $$@
	@echo 'Created $$@ --> OK.'

# All base targets
nodes_implicit_targets+= $(nodes_implicit_dir)/$(basename $(notdir $1)).csv

endef


# Build rules foreach language, foreach template
$(foreach x,$(rs_nodes_implicit), \
	$(eval $(call build-nodes-implicit-rule,$(x))) \
)








