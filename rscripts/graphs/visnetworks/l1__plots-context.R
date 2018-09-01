#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}


l1_plots_context <- function(nodes.csv, edges.csv, output.html){
  
  library(dplyr)
  library(visNetwork)

  # nodes<-read.csv("git/capbreu-builder/builds/nodes/nodes.csv")
  # edges<-read.csv("git/capbreu-builder/builds/edges/edges.csv")
  
  
  nodes<-read.csv(nodes.csv)
  nodes<-
    nodes %>% 
    filter(type=='level1'|type=='plot'|type=='administrative'|type=='anthropic'|type=='rivers'|type=='mountains') %>%
    rename(group="type") %>% 
    # mutate(title=paste(area,' Jornales', '(',area_m2,'m2 aprox.)')) %>%
    mutate(size=area)
  
  edges<-read.csv(edges.csv)
  edges<-
    edges %>% 
    filter(type=='plot-border-l2'|type=='plot-border-l1'|type=='plot-border'|type=='plot-admin-border'|type=='plot-anthropic-border'|type=='plot-rivers-border'|type=='plot-mountains-border') %>% 
    select(from,to,type)
  


  network <-
    visNetwork(nodes, edges, main = "Heredades and Agricultural plots, with context", footer = "Source: Cabreve de Sella (1726)", height = "700px", width = "100%") %>%
    visIgraphLayout(layout = "layout_with_fr") %>%
    visInteraction(multiselect = TRUE,navigationButtons = TRUE) %>% 
    # visEvents(dragEnd = "function (params) {for (var i = 0; i < params.nodes.length; i++) {var nodeId = params.nodes[i];var positions = this.getPositions(nodeId);var x=positions[nodeId].x;var y=positions[nodeId].y; alert('x: ' +  x + ' y: ' +  y);  nodes.update({id: nodeId, x:x, y:y});}}") %>% 
    # visEvents(dragEnd = "function(item) {var positions = this.getPositions(item.nodes); alert('x: ' +  positions[item.nodes].x + ' y: ' +  positions[item.nodes].y);}") %>% 
    #visEvents(hold = "function exportNetwork() {var nodes = Object.values(this.getPositions());var exportValue = JSON.stringify(nodes, undefined, 2);localStorage.setItem('test.json', JSON.stringify(exportValue));}") %>% 
    visOptions(manipulation = TRUE) %>%
    visGroups(groupname = "level1", 
              color = "springgreen", 
              shape = "dot") %>% 
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
    visGroups(groupname = "rivers",    color = "lightblue",    shape = "ellipse") %>%
    visLegend(width = 0.2, position = "right") %>% 
    visEdges(shadow = TRUE,
             color = list(color = "lightgrey", highlight = "white")) %>%
    #visPhysics(enabled = TRUE, solver = "forceAtlas2Based",stabilization = TRUE)%>%
    #visNodes(physics = TRUE)%>%
    #visOptions(collapse = TRUE)%>%
    #visPhysics(stabilization= TRUE)%>%
    addFontAwesome()
  
  network
  
  htmlwidgets::saveWidget(network, basename(output.html))
  
  file.rename(basename(output.html), output.html)
  
}

suppressWarnings(
  suppressMessages(
    l1_plots_context(args[1],args[2],args[3])
  )
)
