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

plot_level2<-
  base_edge_list %>% 
  select(plot.id,level2.id) %>%
  distinct() %>% 
  rename(from="plot.id",to="level2.id") %>% 
  mutate(label="belongs to",type="plot-level2-part") %>% 
  select(from,to,label,type) %>% 
  arrange(from)

write.csv(plot_level2, file = args[2], row.names = FALSE)
