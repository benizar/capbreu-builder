#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}


l1_context <- function(nodes.csv, edges.csv, output.html){
  
  library(dplyr)
  library(visNetwork)
  
  
  nodes<-read.csv(nodes.csv)
  nodes<-
    nodes %>% 
    filter(type=='level1'|type=='administrative'|type=='anthropic'|type=='rivers'|type=='mountains') %>%
    rename(group="type") %>% 
    mutate(title=paste(area,' Jornales', '(',area_m2,'m2 aprox.)')) %>%
    mutate(size=area)
  
  edges<-read.csv(edges.csv)
  edges<-
    edges %>% 
    filter(type=='level1-border'|type=='level1-admin-border'|type=='level1-anthropic-border'|type=='level1-rivers-border'|type=='level1-mountains-border') %>% 
    select(from,to,type)
  
  
  network <-
    visNetwork(nodes, edges, main = "Level1 graph with context", footer = "Source: Cabreve de Sella (1726)", height = "700px", width = "100%") %>%
    visIgraphLayout() %>%
    visInteraction(multiselect = TRUE,navigationButtons = TRUE) %>% 
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
    visLegend(width = 0.2, position = "right") %>% 
    visEdges(shadow = TRUE,
             color = list(color = "lightgrey", highlight = "white"))
  
  network
  
  htmlwidgets::saveWidget(network, basename(output.html))
  
  file.rename(basename(output.html), output.html)
  
}

suppressWarnings(
  suppressMessages(
    l1_context(args[1],args[2],args[3])
  )
)
