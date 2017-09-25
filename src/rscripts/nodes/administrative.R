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
library(dplyr)
library(tidyr)


base_df<-read.csv(args[1])

administrative<-
  base_df %>%
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

write.csv(administrative, file = args[2])
