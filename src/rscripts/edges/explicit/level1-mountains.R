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

base_edge_list<-read.csv(args[1])

level1_mountains<-
  base_edge_list %>% 
  filter(value.type=="Mountains") %>%
  select(level1.id,value.id) %>%
  distinct() %>% 
  rename(from="level1.id",to="value.id") %>% 
  mutate(label="touches",type="level1-mountains-border") %>% 
  select(from,to,label,type) %>% 
  arrange(from)

write.csv(level1_mountains, file = args[2], row.names = FALSE)
