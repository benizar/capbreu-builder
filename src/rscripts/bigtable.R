#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

source("src/rscripts/functions/load-schema.R")
source("src/rscripts/functions/sanitize.R")

#schema<-load_schema("../data/capbreu_load_tests_flat.yml")
schema<-load_schema(args[1])
schema$bigTable$Landholder<-sanitize(schema$bigTable$Landholder)

write.csv(schema$bigTable, file = args[2])
