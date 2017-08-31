#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}


###
# Use magrittr's %>% to create a graph and
# then view it without storing that graph object
###

library(DiagrammeR)
library(magrittr)

df <- data.frame(col1 = c("Cat", "Dog", "Bird"),
                 col2 = c("Feline", "Canis", "Avis"),
                 stringsAsFactors = FALSE)
uniquenodes <- unique(c(df$col1, df$col2))

uniquenodes

library(DiagrammeR)

nodes <- create_node_df(n=length(uniquenodes), 
                        type="number", 
                        label=uniquenodes)
edges <- create_edge_df(from=match(df$col1, uniquenodes), 
                        to=match(df$col2, uniquenodes), 
                        rel="related")
g <- create_graph(nodes_df=nodes, 
                  edges_df=edges)

generate_dot(g)
