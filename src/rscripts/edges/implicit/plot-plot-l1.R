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
flipped_edge_list<-read.csv(args[2])

plot_plot_l1.temp<-
  flipped_edge_list %>% 
  filter(value.type=="Neighbours") %>% 
  select(-value.type) %>% 
  inner_join(.,base_edge_list,by=c("value.id","landholder.id","level1.id","level2.id")) %>%
  filter(plot.id.x != plot.id.y) %>% 
  select(starts_with("plot.id"))

plot_plot_l1.temp<- 
  unique(data.frame(t(apply(plot_plot_l1.temp,1,sort))))

plot_plot_l1<-
  plot_plot_l1.temp %>% 
  mutate(label="touches",type="plot-border") %>% 
  rename(from="X1",to="X2") %>% 
  select(from,to,label,type) %>% 
  arrange(from)

write.csv(plot_plot_l1, file = args[3])
