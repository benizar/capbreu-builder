
# TODO: Could examine results through a first console output

# Examine the data
head(nodes)
head(edges)
nrow(nodes); length(unique(nodes$id))
nrow(edges); nrow(unique(edges[,c("from", "to")]))
