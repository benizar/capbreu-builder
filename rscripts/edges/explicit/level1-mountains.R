#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

level1_mountains <- function(input.csv, output.csv){
  
  library(dplyr)

  base_edge_list<-read.csv(input.csv)
  
  level1_mountains<-
    base_edge_list %>% 
    filter(value.type=="Mountains") %>%
    select(level1.id,value.id) %>%
    distinct() %>% 
    rename(from="level1.id",to="value.id") %>% 
    mutate(label="touches",type="level1-mountains-border") %>% 
    select(from,to,label,type) %>% 
    arrange(from)
  
  write.csv(level1_mountains, file = output.csv, row.names = FALSE)
  
}

suppressWarnings(
  suppressMessages(
    level1_mountains(args[1],args[2])
  )
)
