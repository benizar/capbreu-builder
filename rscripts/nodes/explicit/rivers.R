#! /usr/bin/env Rscript --vanilla --default-packages=magrittr,dplyr,tidyr
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

rivers <- function(schema.csv, rivers.csv){
  
  library(magrittr)
  library(dplyr)

  schema<-read.csv(schema.csv)
  
  rivers<-
    schema %>%
    filter(var_category!="Landmetrics") %>% 
    select(-var_category) %>% 
    filter(var=="Rivers") %>% 
    select(value) %>% 
    unique() %>% 
    rename(label="value") %>% 
    mutate(type="rivers")
  rivers$id <- 
    rivers %>% 
    group_indices(label) %>% 
    paste("RIV",.,sep="-")
  
  write.csv(rivers, file = rivers.csv, row.names = FALSE)
  
}

suppressMessages(
  rivers(args[1],args[2])
)