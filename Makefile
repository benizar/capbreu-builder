include mk/*.mk

## Create all files and outputs from the begining
all: clean
	@echo 'Building relationships'

## Write graph.html
graph.html: $(builds_dir)/graph.html
$(builds_dir)/graph.html: $(rscripts_dir)/graph.html.R \
			$(builds_dir)/graph.gv | checkdirs
	@echo ''
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(word 2, $^) $(@F)
	@mv $(@F) $@
	@echo ''


## Write graph.gv (DOT)
graph.gv: $(builds_dir)/graph.gv
$(builds_dir)/graph.gv: $(rscripts_dir)/graph.gv.R \
			$(builds_dir)/big-table-reshaped.csv \
			$(builds_dir)/agg-landholder.csv \
			$(builds_dir)/just-neigbours.csv\
			$(builds_dir)/agg-l1.csv \
			$(builds_dir)/agg-l2.csv | checkdirs
	@echo ''
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(word 2, $^) $(word 3, $^) $(word 4, $^) $(word 5, $^) $(word 6, $^) $@
	@echo ''

## Agg Landholder
csv-agg-landholder: $(builds_dir)/agg-landholder.csv
$(builds_dir)/agg-landholder.csv: $(rscripts_dir)/write-agg-landholder.R \
				$(builds_dir)/big-table-reshaped.csv | checkdirs
	@echo ''
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(word 2, $^) $@
	@echo ''

## Just Neighbours
csv-just-neigbours: $(builds_dir)/just-neigbours.csv
$(builds_dir)/just-neigbours.csv: $(rscripts_dir)/write-just-neighbours.R \
				$(builds_dir)/big-table.csv \
				$(builds_dir)/agg-landholder.csv| checkdirs
	@echo ''
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(word 2, $^) $(word 3, $^) $@
	@echo ''

## Agg L1
csv-agg-l1: $(builds_dir)/agg-l1.csv
$(builds_dir)/agg-l1.csv: $(rscripts_dir)/write-agg-l1.R \
			$(builds_dir)/big-table-reshaped.csv| checkdirs
	@echo ''
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(word 2, $^) $@
	@echo ''

## Agg L2
csv-agg-l2: $(builds_dir)/agg-l2.csv
$(builds_dir)/agg-l2.csv: $(rscripts_dir)/write-agg-l2.R \
			$(builds_dir)/big-table-reshaped.csv| checkdirs
	@echo ''
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(word 2, $^) $@
	@echo ''

## Write a reshaped big table
csv-reshaped-table: $(builds_dir)/big-table-reshaped.csv
$(builds_dir)/big-table-reshaped.csv: $(rscripts_dir)/write-bigtable-reshaped.R \
					$(builds_dir)/big-table.csv| checkdirs
	@echo ''
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(word 2, $^) $@
	@echo ''


## Write the big table
csv-big-table: $(builds_dir)/big-table.csv
$(builds_dir)/big-table.csv: $(rscripts_dir)/write-bigtable.R | checkdirs
	@echo ''
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(project_data) $@
	@echo ''

## Landmetrics
csv-landmetrics: $(builds_dir)/landmetrics.csv
$(builds_dir)/landmetrics.csv: $(rscripts_dir)/write-landmetrics.R | checkdirs
	@echo ''
	@echo 'Runing Rscript $(<F)...'
	@$(RUN_RSCRIPT) $< $(project_data) $@
	@echo ''

## Levels
csv-agg-levels: $(builds_dir)/aggregation-levels.csv
$(builds_dir)/aggregation-levels.csv: $(rscripts_dir)/write-aggregation-levels.R | checkdirs
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

