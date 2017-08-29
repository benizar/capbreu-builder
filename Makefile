include mk/*.mk

all:
	@echo 'Building relationships'

load-data:
	@echo '	Rscript $(rscripts)/setup.R'

clean:
	@echo 'Cleaning project'
