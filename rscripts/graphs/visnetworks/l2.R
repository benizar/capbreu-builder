#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}


l2_l2 <- function(nodes.csv, edges.csv, output.html){
  
  library(dplyr)
  library(visNetwork)

  # nodes<-read.csv("git/capbreu-builder/builds/nodes/nodes.csv")
  # edges<-read.csv("git/capbreu-builder/builds/edges/edges.csv")
  
  
  nodes<-read.csv(nodes.csv)
  nodes<-
    nodes %>% 
    filter(type=='level2') %>%
    rename(group="type") %>% 
    # mutate(title=paste(area,' Jornales', '(',area_m2,'m2 aprox.)')) %>%
    mutate(size=area)
  
  edges<-read.csv(edges.csv)
  edges<-
    edges %>% 
    filter(type=='level2-border') %>% 
    select(from,to,type)
  
  
  network <-
    visNetwork(nodes, edges, main = "Partidas", submain = "Level2 graph", footer = "Source: Cabreve de Sella (1726)", height = "700px", width = "100%") %>%
    visIgraphLayout(layout = "layout_in_circle") %>%
    visInteraction(multiselect = TRUE,navigationButtons = TRUE) %>% 
    # visEvents(dragEnd = "function (params) {for (var i = 0; i < params.nodes.length; i++) {var nodeId = params.nodes[i];var positions = this.getPositions(nodeId);var x=positions[nodeId].x;var y=positions[nodeId].y; alert('x: ' +  x + ' y: ' +  y);  nodes.update({id: nodeId, x:x, y:y});}}") %>% 
    # visEvents(dragEnd = "function(item) {var positions = this.getPositions(item.nodes); alert('x: ' +  positions[item.nodes].x + ' y: ' +  positions[item.nodes].y);}") %>% 
    #visEvents(hold = "function exportNetwork() {var nodes = Object.values(this.getPositions());var exportValue = JSON.stringify(nodes, undefined, 2);localStorage.setItem('test.json', JSON.stringify(exportValue));}") %>% 
    visOptions(manipulation = TRUE) %>%
    visGroups(groupname = "level2", 
              color = "pink", 
              shape = "dot") %>% 
    visEdges(shadow = TRUE,
             color = list(color = "lightgrey", highlight = "white")) %>%
    visPhysics(solver = "forceAtlas2Based",stabilization = TRUE)
  
  network
  
  htmlwidgets::saveWidget(network, basename(output.html))
  
  file.rename(basename(output.html), output.html)
  
}

suppressWarnings(
  suppressMessages(
    l2_l2(args[1],args[2],args[3])
  )
)
