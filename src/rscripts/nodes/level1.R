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


base_node_list<-read.csv(args[1])

level1<-
  base_node_list %>% 
  rename(id="level1.id",label="level1.label") %>% 
  group_by(id,label) %>%
  summarise(area=sum(area), area_m2=sum(area_m2)) %>% 
  mutate(type="level1")

write.csv(level1, file = args[2])
