
# Need a csv schema from yaml
rs_nodes_explicit   := $(wildcard $(rs_nodes_explicit_dir)/*.R)

# BUILD RULES
define build-nodes-explicit-rule
$(nodes_explicit_dir)/$(basename $(notdir $1)).csv: $1 $(csv_schema) | conjeture
	@echo 'Runing Rscript $$(<F)...'
	@$(RUN_RSCRIPT) $$< $$(filter-out $$<, $$^) $$@
	@echo 'Created $$@ --> OK.'
	@echo ''

# All base targets
nodes_explicit_targets+= $(nodes_explicit_dir)/$(basename $(notdir $1)).csv

endef



$(foreach x,$(rs_nodes_explicit), \
	$(eval $(call build-nodes-explicit-rule,$(x))) \
)


