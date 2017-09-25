#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[1] = "bigTable.csv"
  
} else if (length(args)==2) {
  args[2] = "agg-landholders.csv"
  # default output file
  args[3] = "out.txt"
}

bigTable <- read.csv(args[1])
landholder_agg <- read.csv(args[2])

# Neighbours that are not landholders
justNeighbours<-bigTable[bigTable$Variable == 'Neighbour', ]
justNeighbours<-as.vector(unique(justNeighbours$Value))
justNeighbours<-setdiff(justNeighbours,landholder_agg$name)

write.csv(justNeighbours, file = args[3])
