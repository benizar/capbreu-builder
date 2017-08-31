#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

# wd is the makefile's dir
# TODO: Maybe we can change this
source("src/rscripts/functions/load-schema.R")

schema<-load_schema(args[1])

write.csv(unique(schema$bigTable$Landholder), file = args[2])
