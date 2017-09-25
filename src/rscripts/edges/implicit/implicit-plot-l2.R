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
flipped_edges<-read.csv(args[2])

# Neighbour plots within the same level2, but not same level1
implicit_plot_l2<-
  flipped_edges %>% 
  filter(value.type=="Neighbours") %>% 
  select(-value.type) %>% 
  inner_join(.,base_edge_list,by=c("value.id","landholder.id","level2.id")) %>%
  filter(plot.id.x != plot.id.y) %>% 
  select(starts_with("plot.id"))
implicit_plot_l2<-
  unique(data.frame(t(apply(implicit_plot_l2,1,sort)))) %>% 
  setdiff(implicit_plot_l1)
implicit_plot_l2.final<-
  implicit_plot_l2 %>% 
  mutate(label="touches",type="plot-border-l1") %>% 
  rename(from="X1",to="X2") %>% 
  select(from,to,label,type) %>% 
  arrange(from)

write.csv(implicit_plot_l2.final, file = args[3])
