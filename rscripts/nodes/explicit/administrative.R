#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

administrative <- function(schema.csv, administrative.csv){
  
  library(dplyr)

  schema<-read.csv(schema.csv)
  
  administrative<-
    schema %>%
    filter(var_category!="Landmetrics") %>% 
    select(-var_category) %>% 
    filter(var=="Administrative") %>% 
    select(value) %>% 
    unique() %>% 
    rename(label="value") %>% 
    mutate(type="administrative")
  administrative$id <- 
    administrative %>% 
    group_indices(label) %>% 
    paste("ADM",.,sep="-")
  
  write.csv(administrative, file = administrative.csv, row.names = FALSE)
  
}

suppressWarnings(
  suppressMessages(
    administrative(args[1],args[2])
  )
)

