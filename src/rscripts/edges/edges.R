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

base_df<-read.csv(args[1])
base_df<-read.csv(args[2])
base_df<-read.csv(args[3])
base_df<-read.csv(args[4])
base_df<-read.csv(args[5])
base_df<-read.csv(args[6])
base_df<-read.csv(args[7])
base_df<-read.csv(args[8])
base_df<-read.csv(args[9])
base_df<-read.csv(args[10])
base_df<-read.csv(args[11])
base_df<-read.csv(args[12])

edges<-
  landholder_neighbour %>%
  bind_rows(landholder_level1) %>%
  bind_rows(landholder_level2) %>%
  bind_rows(plot_plot) %>%
  bind_rows(plot_level2) %>%
  bind_rows(plot_level1) %>%
  bind_rows(plot_landholder) %>% 
  bind_rows(plot_natural) %>% 
  bind_rows(plot_anthropic) %>% 
  bind_rows(plot_administrative) %>% 
  bind_rows(implicit_l1_l1.final) %>% 
  bind_rows(implicit_l2_l2.final) %>% 
  arrange(from)

write.csv(base_edge_list, file = args[13])
