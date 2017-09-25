#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

library(magrittr)
library(yaml)
library(dplyr)
library(tidyr)

schema <-read.csv(args[1])
nodes  <-read.csv(args[2])

# Base DataFrame for building different edge lists
base_edge_list<-
  schema %>%
  filter(var_category!="Landmetrics") %>% 
  select(-var_category) %>% 
  rename(label="value") %>% 
  left_join(nodes,by="label") %>% 
  select(-starts_with("area"),-type) %>% 
  rename(value.id="id",value.label="label",value.type="var")

write.csv(base_edge_list, file = args[3])
