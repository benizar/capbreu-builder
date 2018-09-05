#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}


plots_context <- function(nodes.csv, edges.csv, output.html){
  
  library(dplyr)
  library(visNetwork)  
  
  nodes<-read.csv(nodes.csv)
  nodes<-
    nodes %>% 
    filter(type=='plot'|type=='administrative'|type=='anthropic'|type=='rivers'|type=='mountains') %>%
    rename(group="type") %>% 
    #mutate(title=paste(area,' Jornales', '(',area_m2,'m2 aprox.)')) %>%
    mutate(size=area)
  
  edges<-read.csv(edges.csv)
  edges<-
    edges %>% 
    filter(type=='plot-border-l2'|type=='plot-border-l1'|type=='plot-border'|type=='plot-admin-border'|type=='plot-anthropic-border'|type=='plot-rivers-border'|type=='plot-mountains-border') %>% 
    select(from,to,type)
  

  network <-
    visNetwork(nodes, edges, main = "Agricultural plots with context", footer = "Source: Cabreve de Sella (1726)", height = "700px", width = "100%") %>%
    visIgraphLayout(layout = "layout_with_fr") %>%
    visInteraction(multiselect = TRUE,navigationButtons = TRUE) %>%
    visOptions(manipulation = TRUE) %>%
    visGroups(groupname = "plot", 
              color = "sienna", 
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
    visGroups(groupname = "rivers",
              color = "lightblue",
              shape = "ellipse") %>%
    visLegend(width = 0.2, position = "right") %>% 
    visEdges(shadow = TRUE,
             color = list(color = "lightgrey", highlight = "white")) %>%
    visIgraphLayout(layout = "layout_with_kk") #%>%
    #visNodes(physics=TRUE)
  
  network
  
  htmlwidgets::saveWidget(network, basename(output.html))
  
  file.rename(basename(output.html), output.html)
  
}

suppressWarnings(
  suppressMessages(
    plots_context(args[1],args[2],args[3])
  )
)
