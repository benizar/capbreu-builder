#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

level2 <- function(base_node_list.csv, level2.csv){
  
  library(dplyr)
  
  base_node_list<-read.csv(base_node_list.csv)
  
  level2<-
    base_node_list %>% 
    rename(id="level2.id",label="level2.label") %>% 
    group_by(id,label) %>%
    summarise(area=sum(area), area_m2=sum(area_m2)) %>% 
    mutate(type="level2")
  
  write.csv(level2, file = level2.csv, row.names = FALSE)
  
}

suppressWarnings(
  suppressMessages(
    level2(args[1],args[2])
  )
)
