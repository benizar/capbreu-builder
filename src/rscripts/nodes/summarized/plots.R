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


base_node_list<-read.csv(args[1])

plots<-
  base_node_list %>% 
  select(starts_with("plot"),starts_with("area")) %>% 
  mutate(type="plot") %>% 
  rename(id="plot.id",label="plot.label")

write.csv(plots, file = args[2], row.names = FALSE)
