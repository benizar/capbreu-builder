#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

suppressPackageStartupMessages(library(magrittr))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(tidyr))

base_edge_list<-read.csv(args[1])

landholder_neighbour<-
  base_edge_list %>% 
  filter(value.type=="Neighbours") %>% # Keep all repeated links, one relationship can appear more than once
  select(landholder.id, value.id) %>% 
  rename(from="landholder.id",to="value.id") %>% 
  mutate(label="neighbours",type="neighbourhood") %>% 
  select(from,to,label,type) %>% 
  arrange(from)

write.csv(landholder_neighbour, file = args[2], row.names = FALSE)
