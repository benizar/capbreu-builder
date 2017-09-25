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

implicit_plot_l1.final<-read.csv(args[1])
implicit_plot_l2.final<-read.csv(args[2])
implicit_plot_l3.final<-read.csv(args[3])

plot_plot<-
  implicit_plot_l1.final %>% 
  bind_rows(implicit_plot_l2.final) %>%
  bind_rows(implicit_plot_l3.final) %>% 
  arrange(from)

write.csv(plot_plot, file = args[4])
