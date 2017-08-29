include mk/*.mk

all:
	@echo 'Building relationships'

.PHONY: load-data
load-data: $(data) | checkdirs
	@echo 'Runing get-structure.R script...'
	@$(RUN_RSCRIPT)/get-structure.R $<

clean:
	@echo 'Cleaning project'

