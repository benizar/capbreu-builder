#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

landholder_level1 <- function(base_edge_list.csv, landholder_level1.csv){
  
  library(magrittr)
  library(dplyr)
  library(tidyr)
  
  base_edge_list<-read.csv(base_edge_list.csv)
  
  landholder_level1<-
    base_edge_list %>% 
    select(landholder.id, level1.id) %>%
    rename(from="landholder.id",to="level1.id") %>% 
    mutate(label="is member of",type="level1-member") %>% 
    select(from,to,label,type) %>% 
    arrange(from)
  
  write.csv(landholder_level1, file = landholder_level1.csv, row.names = FALSE)
  
}

suppressMessages(
  landholder_level1(args[1],args[2])
)