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

# Explicit
landholder_neighbour <-read.csv(args[1])
landholder_level1    <-read.csv(args[2])
landholder_level2    <-read.csv(args[3])

plot_landholder      <-read.csv(args[4])
plot_level1          <-read.csv(args[5])
plot_level2          <-read.csv(args[6])
plot_administrative  <-read.csv(args[7])
plot_anthropic       <-read.csv(args[8])
plot_mountains         <-read.csv(args[9])
plot_rivers         <-read.csv(args[10])

level1_administrative  <-read.csv(args[11])
level1_anthropic       <-read.csv(args[12])
level1_mountains         <-read.csv(args[13])
level1_rivers         <-read.csv(args[14])

# Implicit
l1_l1                <-read.csv(args[15])
l2_l2                <-read.csv(args[16])
plot_plot            <-read.csv(args[17])


edges<-
  landholder_neighbour %>%
  bind_rows(landholder_level1) %>%
  bind_rows(landholder_level2) %>%
  bind_rows(plot_landholder) %>% 
  bind_rows(plot_level1) %>%
  bind_rows(plot_level2) %>%
  bind_rows(plot_administrative) %>% 
  bind_rows(plot_anthropic) %>% 
  bind_rows(plot_mountains) %>% 
  bind_rows(plot_rivers) %>% 
  bind_rows(level1_administrative) %>% 
  bind_rows(level1_anthropic) %>% 
  bind_rows(level1_mountains) %>% 
  bind_rows(level1_rivers) %>% 
  bind_rows(l1_l1) %>% 
  bind_rows(l2_l2) %>% 
  bind_rows(plot_plot) %>%
  arrange(from)

write.csv(edges, file = args[18], row.names = FALSE)
