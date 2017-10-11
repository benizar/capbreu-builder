#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

mountains <- function(schema.csv, mountains.csv){
  
  library(dplyr)

  schema<-read.csv(schema.csv)
  
  mountains<-
    schema %>%
    filter(var_category!="Landmetrics") %>% 
    select(-var_category) %>% 
    filter(var=="Mountains") %>% 
    select(value) %>% 
    unique() %>% 
    rename(label="value") %>% 
    mutate(type="mountains")
  mountains$id <- 
    mountains %>% 
    group_indices(label) %>% 
    paste("MNT",.,sep="-")
  
  write.csv(mountains, file = mountains.csv, row.names = FALSE)
  
}

suppressWarnings(
  suppressMessages(
    mountains(args[1],args[2])
  )
)
