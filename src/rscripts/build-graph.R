#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

#TODO: http://kateto.net/wp-content/uploads/2016/06/Polnet%202016%20R%20Network%20Visualization%20Workshop.pdf

# FUNCTIONS
# x = reshaped df
build_graph<-function(landholder_agg,justNeighbours,l1_agg,l2_agg, bigTable){
  
  library(igraph)
  
  nname<-c(sanitize(as.vector(landholder_agg$name)),
           sanitize(l2_agg$name))
  ncolor<-c(rep("blue", length(landholder_agg$name)),
           rep("red", length(l2_agg$name)))
  narea<-c(landholder_agg$area,
           l2_agg$area)

  nodes <- data.frame(name=nname[!duplicated(nname)],
                      color=ncolor,
                      area=narea)
  
  edges <- data.frame(from=sanitize(as.vector(reshaped_bigtable$Landholder)),
                      to= sanitize(as.vector(reshaped_bigtable$Level_2)))
  
  g <- graph_from_data_frame(edges, directed=TRUE, vertices=nodes)
  
  g
  
  #  write_graph(graph, file, format = c("edgelist", "pajek", "ncol", "lgl", "graphml", "dimacs", "gml", "dot", "leda"), ...)
}

bigTable <- read.csv(args[1])
justNeighbours <- read.csv(args[2])
landholder_agg <- read.csv(args[3])
l1_agg <- read.csv(args[4])
l2_agg <- read.csv(args[5])

g<-build_graph(landholder_agg,justNeighbours,l1_agg,l2_agg, bigTable)
