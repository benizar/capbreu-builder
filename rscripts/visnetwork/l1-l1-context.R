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
library(visNetwork)

nodes<-read.csv(args[1])
nodes<-
  nodes %>% 
  filter(type=='level1'|type=='administrative'|type=='anthropic'|type=='rivers'|type=='mountains') %>%
  rename(group="type",size="area")

edges<-read.csv(args[2])
edges<-
  edges %>% 
  filter(type=='level1-border'|type=='level1-admin-border'|type=='level1-anthropic-border'|type=='level1-rivers-border'|type=='level1-mountains-border') %>% 
  select(from,to,type)


visNetwork(nodes, edges, height = "800px", width = "100%") %>%
  visGroups(groupname = "level1", 
            color = "orange", 
            shape = "dot") %>% 
  visGroups(groupname = "administrative", 
            color = "tomato", 
            shape = "diamond") %>%
  visGroups(groupname = "anthropic", 
            color = "gold", 
            shape = "square") %>%
  visGroups(groupname = "mountains", 
            color = "green",   
            shape = "triangle") %>%
  visGroups(groupname = "rivers",    color = "lightblue",    shape = "ellipse") %>%
  visEdges(shadow = TRUE,
           color = list(color = "grey", highlight = "darkgrey")) %>%
  visPhysics(solver = "forceAtlas2Based",stabilization = TRUE)