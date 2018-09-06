#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

anthropic <- function(schema.csv, administrative.csv){
  
  library(dplyr)

  schema<-read.csv(schema.csv)
  
  anthropic<-
    schema %>%
    filter(var_category!="Landmetrics") %>% 
    select(-var_category) %>% 
    filter(var=="Anthropic") %>% 
    select(value) %>% 
    unique() %>% 
    rename(label="value") %>% 
    mutate(type="anthropic") %>%
    mutate(area=10)
  anthropic$id <- 
    anthropic %>% 
    group_indices(label) %>% 
    paste("ANT",.,sep="-")
  
  write.csv(anthropic, file = args[2], row.names = FALSE)
  
}

suppressWarnings(
  suppressMessages(
    anthropic(args[1],args[2])
  )
)
