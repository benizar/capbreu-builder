#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}


l1_plot_context <- function(nodes.csv, edges.csv, output.html){
  
  library(dplyr)
  library(visNetwork)
  
  
  nodes<-read.csv(nodes.csv)
  nodes<-
    nodes %>% 
    filter(type=='landholder'|type=='just_neighbour') %>%
    rename(group="type") %>% 
    mutate(title=paste(area,' Jornales', '(',area_m2,'m2 aprox.)')) %>%
    mutate(size=area)
  
  edges<-read.csv(edges.csv)
  edges<-
    edges %>% 
    filter(type=='neighbourhood') %>% 
    select(from,to,type)
  
  
  network <-
    visNetwork(nodes, edges, main = "Emphyteutas", submain = "(and other people)", footer = "Source: Cabreve de Sella (1726)", height = "700px", width = "100%") %>%
    visIgraphLayout() %>%
    visInteraction(multiselect = TRUE,navigationButtons = TRUE) %>% 
    visOptions(manipulation = TRUE) %>%
    visGroups(groupname = "landholder", 
              shape = "icon", 
              icon = list(code = "f007", color = "blue")) %>%
    visGroups(groupname = "just_neighbour", 
              shape = "icon", 
              icon = list(code = "f007", color = "red")) %>%
    visLegend(width = 0.2, position = "right") %>% 
    visEdges(shadow = TRUE,
             color = list(color = "lightgrey", highlight = "white")) %>%
    addFontAwesome()
  
  network
  
  htmlwidgets::saveWidget(network, basename(output.html))
  
  file.rename(basename(output.html), output.html)
  
}

suppressWarnings(
  suppressMessages(
    l1_plot_context(args[1],args[2],args[3])
  )
)
