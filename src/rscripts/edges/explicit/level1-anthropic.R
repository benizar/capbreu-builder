#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

level1_anthropic <- function(input.csv, output.csv){
  
  library(magrittr)
  library(dplyr)
  library(tidyr)
  
  base_edge_list<-read.csv(input.csv)
  
  level1_anthropic<-
    base_edge_list %>% 
    filter(value.type=="Anthropic") %>%
    select(level1.id,value.id) %>%
    distinct() %>% 
    rename(from="level1.id",to="value.id") %>% 
    mutate(label="touches",type="level1-anthropic-border") %>% 
    select(from,to,label,type) %>% 
    arrange(from)
  
  write.csv(level1_anthropic, file = output.csv, row.names = FALSE)
  
}

suppressMessages(
  level1_anthropic(args[1],args[2])
)