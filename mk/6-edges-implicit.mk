
# RSCRIPTS (-rs_flipped)
rs_edges_implicit := $(filter-out $(rs_flipped),$(wildcard $(rscripts_implicit_edges_dir)/*.R))


# BUILD RULES
define build-edges-implicit-rule
$(edges_implicit_dir)/$(basename $(notdir $1)).csv: $1 $(csv_base_edge_list) $(csv_flipped) | checkdirs
	@echo ''
	@echo 'Runing Rscript $$(<F)...'
	@$(RUN_RSCRIPT) $$< $$(filter-out $$<, $$^) $$@
	@echo 'Created $$@ --> OK.'

# All base targets
edges_implicit_targets+= $(edges_implicit_dir)/$(basename $(notdir $1)).csv

endef



# Build rules foreach language, foreach template
$(foreach x,$(rs_edges_implicit), \
	$(eval $(call build-edges-implicit-rule,$(x))) \
)

## Builds implicit edges from base-edge-list
build-edges-im: $(edges_implicit_targets)
