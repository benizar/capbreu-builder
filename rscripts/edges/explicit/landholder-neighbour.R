#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

landholder_neighbour <- function(input.csv, output.csv){
  
  library(magrittr)
  library(dplyr)
  library(tidyr)
  
  base_edge_list<-read.csv(input.csv)
  
  landholder_neighbour<-
    base_edge_list %>% 
    filter(value.type=="Neighbours") %>% # Keep all repeated links, one relationship can appear more than once
    select(landholder.id, value.id) %>% 
    rename(from="landholder.id",to="value.id") %>% 
    mutate(label="neighbours",type="neighbourhood") %>% 
    select(from,to,label,type) %>% 
    arrange(from)
  
  write.csv(landholder_neighbour, file = output.csv, row.names = FALSE)
  
}


suppressMessages(
  landholder_neighbour(args[1],args[2])
)