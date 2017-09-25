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

yaml <- yaml.load_file(args[1])

proj <-
  yaml %$%
  data.frame(Structure,Title,Description) %>% 
  gather()

write.csv(proj, file = args[2])
