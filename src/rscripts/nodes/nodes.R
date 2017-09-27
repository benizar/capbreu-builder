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


landholders    <-read.csv(args[1])
neighbours     <-read.csv(args[2])
plots          <-read.csv(args[3])
level1         <-read.csv(args[4])
level2         <-read.csv(args[5])
mountains        <-read.csv(args[6])
rivers        <-read.csv(args[7])
anthropic      <-read.csv(args[8])
administrative <-read.csv(args[9])


nodes<-
  landholders %>%
  bind_rows(neighbours) %>% 
  bind_rows(plots) %>%
  bind_rows(level1) %>%
  bind_rows(level2) %>%
  bind_rows(mountains) %>%
  bind_rows(rivers) %>%
  bind_rows(anthropic) %>% 
  bind_rows(administrative)

write.csv(nodes, file = args[10], row.names = FALSE)
