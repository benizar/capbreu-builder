#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}


l2 <- function(nodes.csv, edges.csv, output.html){
  
  library(dplyr)
  library(visNetwork)
  
  
  nodes<-read.csv(nodes.csv)
  nodes<-
    nodes %>% 
    filter(type=='level2') %>%
    rename(group="type") %>% 
    mutate(title=paste(area,' Jornales', '(',area_m2,'m2 aprox.)')) %>%
    mutate(size=sqrt(area)*pi)
  
  edges<-read.csv(edges.csv)
  edges<-
    edges %>% 
    filter(type=='level2-border') %>% 
    select(from,to,type)
  
  
  network <-
    visNetwork(nodes, edges, main = "Partidas", submain = "Level2 graph", footer = "Source: Cabreve de Sella (1726)", height = "700px", width = "100%") %>%
    visIgraphLayout(layout = "layout_in_circle") %>%
    visInteraction(multiselect = TRUE,navigationButtons = TRUE) %>% 
    visOptions(manipulation = TRUE) %>%
    visGroups(groupname = "level2", 
              color = "pink", 
              shape = "dot") %>% 
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
    l2(args[1],args[2],args[3])
  )
)
