#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

landholders <- function(base_node_list.csv, landholders.csv){
  
  library(dplyr)

  base_node_list<-read.csv(base_node_list.csv)
  
  landholders<-
    base_node_list %>% 
    group_by(landholder.id,landholder.label) %>% 
    summarise(area=sum(area), area_m2=sum(area_m2)) %>% 
    mutate(type="landholder") %>% 
    rename(id="landholder.id",label="landholder.label")
  
  write.csv(landholders, file = landholders.csv, row.names = FALSE)
  
}

suppressWarnings(
  suppressMessages(
    landholders(args[1],args[2])
  )
)
