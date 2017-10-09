#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

# GRAPHS
library(dplyr)
library(igraph)
library(Cairo)


nodes<-read.csv(args[1])
nodes<-
  nodes %>% 
  filter(type=='level1'|type=='administrative'|type=='anthropic'|type=='rivers'|type=='mountains') %>%
  rename(name="id",size="area") %>% 
  select(name,lat,lon,size)

edges<-read.csv(args[2])
edges<-
  edges %>% 
  filter(type=='level1-border'|type=='level1-admin-border'|type=='level1-anthropic-border'|type=='level1-rivers-border'|type=='level1-mountains-border') %>% 
  select(from,to,type)


g <- graph_from_data_frame(edges, directed=TRUE, vertices=nodes)

#lo <- layout.norm(as.matrix(nodes[,2:3]))

png(args[3], 600, 400)

plot.igraph(g)

dev.off()
