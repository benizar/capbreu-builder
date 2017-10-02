#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

flipped_edges <- function(base_edge_list.csv, flipped_edge_list.csv){
  
  library(magrittr)
  library(dplyr)
  library(tidyr)
  
  base_edge_list<-read.csv(base_edge_list.csv)
  
  flipped_edges<-
    base_edge_list %>% 
    rename(value.id="landholder.id",value.label="landholder.label",landholder.id="value.id",landholder.label="value.label")
  
  write.csv(flipped_edges, file = flipped_edge_list.csv, row.names = FALSE)
  
}

suppressMessages(
  flipped_edges(args[1],args[2])
)
