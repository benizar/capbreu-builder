include mk/*.mk

all:
	@echo 'Building relationships'

.PHONY: load-data
load-data: $(data) | checkdirs
	@echo 'Runing get-structure.R script...'
	@echo $(shell Rscript $(rscripts_dir)/get-structure.R $<)

clean:
	@echo 'Cleaning project'

