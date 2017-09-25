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


schema      <-read.csv(args[1])
landholders <-read.csv(args[2])

neighbours<-
  schema %>%
  filter(var_category!="Landmetrics") %>% 
  select(-var_category) %>% 
  filter(var=="Neighbours") %>% 
  select(value) %>% 
  rename(label="value") %>% 
  unique() %>% 
  anti_join(., landholders, by = c("label")) %>% 
  mutate(type="just_neighbour")
neighbours$id<-
  neighbours %>% 
  group_indices(label) %>% 
  paste("NEI",.,sep="-")

write.csv(neighbours, file = args[3])
