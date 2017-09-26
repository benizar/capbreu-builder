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

plot_natural<-
  base_edge_list %>% 
  filter(value.type=="Natural") %>%
  select(plot.id,value.id) %>%
  distinct() %>% 
  rename(from="plot.id",to="value.id") %>% 
  mutate(label="touches",type="plot-natural-border") %>% 
  select(from,to,label,type) %>% 
  arrange(from)

write.csv(plot_natural, file = args[2], row.names = FALSE)
