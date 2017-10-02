#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

context <- function(input.yaml, output.csv){
  
  library(magrittr)
  library(yaml)
  library(dplyr)
  library(tidyr)
  
  yaml <- yaml.load_file(input.yaml)
  
  # Context data
  context_df <-
    yaml %$%
    data.frame(Landmetrics,Aggregations) %>% 
    gather()
  
  write.csv(context_df, file = output.csv, row.names = FALSE)
  
}

# At debugging time turn these on
options(warn=-1)
#options(warn=0)

# Function call
suppressMessages(
  context(args[1],args[2])
)



