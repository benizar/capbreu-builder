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

landholder_neighbour <-read.csv(args[1])
landholder_level1    <-read.csv(args[2])
landholder_level2    <-read.csv(args[3])
plot_plot            <-read.csv(args[4])
plot_level2          <-read.csv(args[5])
plot_level1          <-read.csv(args[6])
plot_landholder      <-read.csv(args[7])
plot_natural         <-read.csv(args[8])
plot_anthropic       <-read.csv(args[9])
plot_administrative  <-read.csv(args[10])
l1_l1                <-read.csv(args[11])
l2_l2                <-read.csv(args[12])


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
  bind_rows(l1_l1) %>% 
  bind_rows(l2_l2) %>% 
  arrange(from)

write.csv(edges, file = args[13])
