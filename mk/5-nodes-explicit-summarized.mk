
# Summarized need a base-node-list with aggregated metrics
rs_nodes_summarized := $(wildcard $(rs_nodes_summarized_dir)/*.R)

# BUILD RULES
define build-nodes-summarized-rule
$(nodes_summarized_dir)/$(basename $(notdir $1)).csv: $1 $(csv_base_node_list) | checkdirs
	@echo ''
	@echo 'Runing Rscript $$(<F)...'
	@$(RUN_RSCRIPT) $$< $$(filter-out $$<, $$^) $$@
	@echo 'Created $$@ --> OK.'

# All base targets
nodes_summarized_targets+= $(nodes_summarized_dir)/$(basename $(notdir $1)).csv

# Automatically create base variables, necessary in other rules.
# TODO: Define what should we do if these variables are not created
ifneq (,$(findstring landholders,$1))
    # Found
csv_landholders=$(nodes_summarized_dir)/$(basename $(notdir $1)).csv
else
    # Not found
endif

endef




$(foreach x,$(rs_nodes_summarized), \
	$(eval $(call build-nodes-summarized-rule,$(x))) \
)

## Builds summarized nodes from csv_base_node_list
nodes-summarized: $(nodes_summarized_targets)

