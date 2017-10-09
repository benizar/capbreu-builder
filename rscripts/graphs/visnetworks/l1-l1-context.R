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
  rename(group="type") %>% 
  mutate(size=sqrt(area)*3)

edges<-read.csv(args[2])
edges<-
  edges %>% 
  filter(type=='level1-border'|type=='level1-admin-border'|type=='level1-anthropic-border'|type=='level1-rivers-border'|type=='level1-mountains-border') %>% 
  select(from,to,type)


network <-
  visNetwork(nodes, edges, main = "Level1 graph with context", height = "700px", width = "100%") %>%
  visIgraphLayout() %>%
  visInteraction(navigationButtons = TRUE) %>% 
  visOptions(manipulation = TRUE) %>%
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
  visLegend(width = 0.1, position = "right", main = "Legend") %>% 
  visEdges(shadow = TRUE,
           color = list(color = "lightgrey", highlight = "white")) %>%
  visPhysics(solver = "forceAtlas2Based",stabilization = TRUE)


htmlwidgets::saveWidget(network, basename(args[3]))

file.rename(basename(args[3]), args[3])
