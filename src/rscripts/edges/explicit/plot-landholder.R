#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

plot_landholder <- function(input.csv, output.csv){
  
  library(magrittr)
  library(dplyr)
  library(tidyr)
  
  base_edge_list<-read.csv(input.csv)
  
  plot_landholder<-
    base_edge_list %>% 
    select(landholder.id, plot.id) %>%
    distinct() %>% 
    rename(from="landholder.id",to="plot.id") %>% 
    mutate(label="holded by",type="landholding") %>% 
    select(from,to,label,type) %>% 
    arrange(from)
  
  write.csv(plot_landholder, file = output.csv, row.names = FALSE)
  
}

suppressMessages(
  plot_landholder(args[1],args[2])
)