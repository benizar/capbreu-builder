#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

level2_anthropic <- function(input.csv, output.csv){
  
  library(dplyr)

  base_edge_list<-read.csv(input.csv)
  
  level2_anthropic<-
    base_edge_list %>% 
    filter(value.type=="Anthropic") %>%
    select(level2.id,value.id) %>%
    distinct() %>% 
    rename(from="level2.id",to="value.id") %>% 
    mutate(label="touches",type="level2-anthropic-border") %>% 
    select(from,to,label,type) %>% 
    arrange(from)
  
  write.csv(level2_anthropic, file = output.csv, row.names = FALSE)
  
}

suppressWarnings(
  suppressMessages(
    level2_anthropic(args[1],args[2])
  )
)
