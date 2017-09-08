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

library(readr)
library(igraph)
library(visNetwork)

g.dot <- read_file(args[1])

# Use DOT language data
graph<-visNetwork(dot = g.dot, main = "Enfiteutas por Heredad", height = "800px", width = "100%")%>% 
  visInteraction(navigationButtons = TRUE) %>%
visEvents(selectNode = "function(properties) {
      alert('selected nodes ' + this.body.data.nodes.get(properties.nodes[0]).group);}")

# Export (Caution Error in normalizePath(basepath, "/", TRUE) : )
htmlwidgets::saveWidget(graph, file=args[2], selfcontained = TRUE)
