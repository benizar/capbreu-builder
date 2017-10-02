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
write_graph_landholders_level1<-function(reshaped_bigtable, landholder_agg,l1_agg, out.gv){
  
  library(igraph)
  
  lh<-landholder_agg$name<-sanitize(landholder_agg$name)
  l1<-l1_agg$name<-paste(sanitize(l1_agg$name),"l1",sep = "-")

  nname<-c(lh,l1)
  
  ncolor<-c(rep("blue", length(lh)),
           rep("red", length(l1)))
  
  ngroup<-c(rep("Enfiteutas", length(lh)),
           rep("Heredades", length(l1)))
  
  norder<-c(rep(2, length(lh)),
           rep(1, length(l1)))
  
  nshape<-c(rep("dot", length(lh)),
           rep("square", length(l1)))
  
  nsize<-c(landholder_agg$area,
           l1_agg$area)

  nodes <- data.frame(name=nname,
                      label=nname,
                      group=ngroup,
                      color=ncolor,
                      order=norder,
                      shape=nshape,
                      size=nsize)
  
  
  lh<-sanitize(reshaped_bigtable$Landholder)
  l1<-paste(sanitize(reshaped_bigtable$Level_1),"l1",sep = "-")

  from <-c(lh)
  to <-c(l1)

  edges <- data.frame(from=from,
                      to=to)
  
  g <- graph_from_data_frame(edges, directed=TRUE, vertices=nodes)
  
  write_graph(g, out.gv, "dot")
}

# TASKS
message (paste("Loading", args[1], "..."))
reshaped_bigtable <- read.csv(args[1])

message (paste("Loading", args[2], "..."))
landholder_agg <- read.csv(args[2])

message (paste("Loading", args[3], "..."))
l1_agg <- read.csv(args[3])


message (paste("Building",args[4]))
suppressMessages(write_graph_landholders_level1(reshaped_bigtable, landholder_agg, l1_agg, args[4]))
message ("File created successfully!!")



