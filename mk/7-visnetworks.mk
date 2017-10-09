
# RSCRIPTS
rs_visnetworks := $(wildcard $(rs_visnetworks_dir)/*.R)

# BUILD RULES
define build-visnetwork-rule
$(visnetworks_dir)/$(basename $(notdir $1)).html: $1 $(csv_nodes) $(csv_edges) | conjeture
	@echo 'Runing Rscript $$(<F)...'
	@$(RUN_RSCRIPT) $$< $$(filter-out $$<, $$^) $$@
	@echo 'Created $$@ --> OK.'
	@echo ''

# All base targets
visnetwork_targets+= $(visnetworks_dir)/$(basename $(notdir $1)).html

endef



# Build rules foreach language, foreach template
$(foreach x,$(rs_visnetworks), \
	$(eval $(call build-visnetwork-rule,$(x))) \
)

