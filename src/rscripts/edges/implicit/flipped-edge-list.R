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

flipped_edges<-
  base_edge_list %>% 
  rename(value.id="landholder.id",value.label="landholder.label",landholder.id="value.id",landholder.label="value.label")

write.csv(flipped_edges, file = args[2], row.names = FALSE)
