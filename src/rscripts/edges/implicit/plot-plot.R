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

plot_plot_l1<-read.csv(args[1])
plot_plot_l2<-read.csv(args[2])
plot_plot_l3<-read.csv(args[3])

plot_plot<-
  plot_plot_l1 %>% 
  bind_rows(plot_plot_l2) %>%
  bind_rows(plot_plot_l3) %>% 
  arrange(from)

write.csv(plot_plot, file = args[4], row.names = FALSE)
