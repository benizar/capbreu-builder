include mk/*.mk

## Create all files and outputs from the begining
all: clean
	@echo 'Building relationships'

## Build all targets from this makefile
build-all: $(builds_dir)/landholder-plots-rules.mk

$(builds_dir)/landholder-plots-rules.mk: $(project_data) $(rs_write_rules) | checkdirs
	@echo ''
	@echo 'Runing Rscripts ...'
	@echo 'Rscript $(word 2, $^) $< $@'
	@$(RUN_RSCRIPT) $(word 2, $^) $< $@
	@echo ''

$(builds_dir)/landholders-list: $(project_data) $(rs_write_landholders_list) | checkdirs
	@echo ''
	@echo 'Runing Rscripts ...'
	@echo 'Rscript $(word 2, $^) $< $@'
	@$(RUN_RSCRIPT) $(word 2, $^) $< $@
	@echo ''

.PHONY: clean
## Clean project
clean:
	@echo ''
	@echo 'Cleaning project ...'
	$(RM) $(builds_dir)/landholders-list
	$(RM) $(builds_dir)/landholder-plots-rules.mk
	@echo ''

