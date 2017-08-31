include mk/*.mk

## Create all files and outputs from the begining
all: clean
	@echo 'Building relationships'



$(builds_dir)/random-graph.pdf: $(rscripts_dir)/random-graph.R | checkdirs
	@echo ''
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(project_data) $@
	@echo ''


## Build all targets from this makefile
build-csv: $(rs_csv_targets)

build-pdf: $(rs_pdf_targets)

$(builds_dir)/%.pdf: $(rscripts_dir)/%.R | checkdirs
	@echo ''
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(project_data) $@
	@echo ''

$(builds_dir)/%.csv: $(rscripts_dir)/%.R | checkdirs
	@echo ''
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(project_data) $@
	@echo ''

.PHONY: clean
## Clean project
clean: | checkdirs
	@echo ''
	@echo 'Cleaning project ...'
	$(RM) $(builds_dir)/*
	@echo ''

