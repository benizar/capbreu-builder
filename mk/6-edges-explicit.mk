# RSCRIPTS
rs_base_edge_list := $(rs_edges_dir)/base-edge-list.R

# TARGETS
csv_base_edge_list := $(patsubst $(rs_edges_dir)/%.R,$(edges_dir)/%.csv,$(rs_base_edge_list))



# RSCRIPTS
rs_edges_explicit := $(wildcard $(rs_edges_explicit_dir)/*.R)

# BUILD RULES
define build-edges-explicit-rule
$(edges_explicit_dir)/$(basename $(notdir $1)).csv: $1 $(csv_base_edge_list) | conjeture
	@echo 'Runing Rscript $$(<F)...'
	@$(RUN_RSCRIPT) $$< $$(filter-out $$<, $$^) $$@
	@echo 'Created $$@ --> OK.'
	@echo ''

# All base targets
edges_explicit_targets+= $(edges_explicit_dir)/$(basename $(notdir $1)).csv

endef



# Build rules foreach language, foreach template
$(foreach x,$(rs_edges_explicit), \
	$(eval $(call build-edges-explicit-rule,$(x))) \
)



