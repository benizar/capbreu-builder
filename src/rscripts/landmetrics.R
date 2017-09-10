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

message(paste("Writting", args[2]))
schema<-load_schema(args[1])
#schema<-load_schema("../data/capbreu_load_tests_flat.yml")

write.csv(as.data.frame(schema$landmetrics), file = args[2])
# Then you can: read.csv("landmetrics.csv",row.names=1)
