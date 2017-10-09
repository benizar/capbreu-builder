
# RSCRIPTS
rs_igraphs := $(wildcard $(rs_igraphs_dir)/*.R)

# BUILD RULES
define build-igraph-rule
$(igraphs_dir)/$(basename $(notdir $1)).png: $1 $(csv_nodes) $(csv_edges) | conjeture
	@echo 'Runing Rscript $$(<F)...'
	@$(RUN_RSCRIPT) $$< $$(filter-out $$<, $$^) $$@
	@echo 'Created $$@ --> OK.'
	@echo ''

# All base targets
igraph_targets+= $(igraphs_dir)/$(basename $(notdir $1)).png

endef



# Build rules foreach language, foreach template
$(foreach x,$(rs_igraphs), \
	$(eval $(call build-igraph-rule,$(x))) \
)


