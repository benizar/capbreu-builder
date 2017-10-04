#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}


bind.csvs <- function(input.csvs){
  
  library(dplyr)
  library(readr)
  df <- 
    input.csvs[-length(input.csvs)] %>% 
    lapply(read_csv) %>%
    bind_rows %>%
    write.csv(file = input.csvs[length(input.csvs)], row.names = FALSE)
  
}

suppressMessages(
  bind.csvs(args)
)