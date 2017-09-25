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
library(igraph)


nodes<-read.csv(args[1])
edges<-read.csv(args[2])

g <- graph_from_data_frame(edges, directed=FALSE, vertices=nodes)

write_graph(g, args[3], "dot")
