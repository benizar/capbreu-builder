#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

reshaped_bigtable<-read.csv(args[1])

# Aggregate
landholder_agg<-aggregate(reshaped_bigtable$Area, by=list(reshaped_bigtable$Landholder), FUN=sum, na.rm=TRUE)
colnames(landholder_agg) <- c('name', 'area')

write.csv(landholder_agg, file = args[2])
