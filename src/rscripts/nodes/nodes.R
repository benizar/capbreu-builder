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

landholders    <-read.csv(args[1])
level1         <-read.csv(args[2])
level2         <-read.csv(args[3])
plots          <-read.csv(args[4])

mountains      <-read.csv(args[5])
rivers         <-read.csv(args[6])
anthropic      <-read.csv(args[7])
administrative <-read.csv(args[8])

neighbours     <-read.csv(args[9])

nodes<-
  landholders %>%
  bind_rows(level1) %>%
  bind_rows(level2) %>%
  bind_rows(plots) %>%
  bind_rows(mountains) %>%
  bind_rows(rivers) %>%
  bind_rows(anthropic) %>% 
  bind_rows(administrative) %>% 
  bind_rows(neighbours)

write.csv(nodes, file = args[10], row.names = FALSE)