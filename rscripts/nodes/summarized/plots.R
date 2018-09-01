#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

plots <- function(base_node_list.csv, plots.csv){
  
  library(dplyr)

  base_node_list<-read.csv(base_node_list.csv)
  
  plots<-
    base_node_list %>% 
    select(starts_with("plot"),starts_with("area"),starts_with("level1.label")) %>% 
    mutate(type="plot") %>% 
    rename(id="plot.id",label="plot.label",title="level1.label")
  
  write.csv(plots, file = plots.csv, row.names = FALSE)
  
}

suppressWarnings(
  suppressMessages(
    plots(args[1],args[2])
  )
)
