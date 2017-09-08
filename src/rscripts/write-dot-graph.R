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

# SOURCES?
source("src/rscripts/functions/sanitize.R")

# FUNCTIONS
write_dot_graph<-function(reshaped_bigtable, landholder_agg,justNeighbours,l1_agg,l2_agg, out.gv){
  
  message ("Building igraph ...")
  library(igraph)
  
  nname<-c(sanitize(as.vector(landholder_agg$name)),
           sanitize(l1_agg$name))
  ncolor<-c(rep("blue", length(landholder_agg$name)),
           rep("red", length(l1_agg$name)))
  ngroup<-c(rep("Enfiteutas", length(landholder_agg$name)),
           rep("Heredades", length(l1_agg$name)))
  norder<-c(rep(2, length(landholder_agg$name)),
           rep(1, length(l1_agg$name)))
  nshape<-c(rep("circle", length(landholder_agg$name)),
           rep("square", length(l1_agg$name)))
  nsize<-c(landholder_agg$area,
           l1_agg$area)

  nodes <- data.frame(name=nname[!duplicated(nname)],
                      label=nname[!duplicated(nname)],
                      group=ngroup,
                      color=ncolor,
                      order=norder,
                      size=nsize)
  
  from <-c(sanitize(as.vector(reshaped_bigtable$Landholder)))
  to <-c(sanitize(as.vector(reshaped_bigtable$Level_1)))

  edges <- data.frame(from=from,
                      to=to)
  
  g <- graph_from_data_frame(edges, directed=TRUE, vertices=nodes)
  
  message ("Writing graph to DOT file ...")
  write_graph(g, out.gv, "dot")
}

# TASKS
message (paste("Loading", args[1], "..."))
reshaped_bigtable <- read.csv(args[1])

message (paste("Loading", args[2], "..."))
landholder_agg <- read.csv(args[2])

message (paste("Loading", args[3], "..."))
justNeighbours <- read.csv(args[3])

message (paste("Loading", args[4], "..."))
l1_agg <- read.csv(args[4])

message (paste("Loading", args[5], "..."))
l2_agg <- read.csv(args[5])

message ("Building DOT graph ...")
write_dot_graph(reshaped_bigtable, landholder_agg, justNeighbours, l1_agg, l2_agg, args[6])
message ("File ... created successfully.")



