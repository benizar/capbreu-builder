

build_dot<-function(x){
  
  library(igraph)
  
  bigTable<-x$bigTable
  conversion<-x$landmetrics
  Area_unit<-as.character(conversion[1])
  Area_conv<-as.numeric(conversion[2])
  m2<-'m2'
  l1_name<-x$aggregation_levels['Level_1']
  l2_name<-x$aggregation_levels['Level_2']
  
  ##Subset, reshape and convert area to m2
  aggregations<-bigTable[bigTable$VarCategory != 'Limits', ]
  aggregations<-dcast(aggregations,Landholder+Plot~Variable,value.var = "Value")
  aggregations$Area<-as.numeric(aggregations$Area)
  aggregations$Area_m2<-aggregations$Area*Area_conv
  
  # Aggregations
  landholder_agg<-aggregate(aggregations$Area, by=list(aggregations$Landholder), FUN=sum, na.rm=TRUE)
  colnames(landholder_agg) <- c('name', 'area')
  
  l1_agg<-aggregate(aggregations$Area, by=list(aggregations$Level_1), FUN=sum, na.rm=TRUE)
  colnames(l1_agg) <- c('name', 'area')
  
  l2_agg<-aggregate(aggregations$Area, by=list(aggregations$Level_2), FUN=sum, na.rm=TRUE)
  colnames(l2_agg) <- c('name', 'area')
  
  # Neighbours that are not landholders
  justNeighbours<-bigTable[bigTable$Variable == 'Neighbour', ]
  justNeighbours<-as.vector(unique(justNeighbours$Value))
  justNeighbours<-setdiff(justNeighbours,landholder_agg$name)
  
  
  nodes <- data.frame(name=c(sanitize(as.vector(landholder_agg$name)),
                             sanitize(justNeighbours),
                             sanitize(l1_agg$name),
                             sanitize(l2_agg$name)),
                      type=c(rep("LH", length(landholder_agg$name)),
                             rep("JN", length(justNeighbours)),
                             rep("L1", length(l1_agg$name)),
                             rep("L2", length(l2_agg$name))),
                      area=c(landholder_agg$area,
                             rep(0, length(justNeighbours)),
                             l1_agg$area,
                             l2_agg$area))
  
  g <- graph_from_data_frame(relations, directed=TRUE, vertices=actors)
  
  write_graph(graph, file, format = c("edgelist", "pajek", "ncol", "lgl",
                                      "graphml", "dimacs", "gml", "dot", "leda"), ...)
}

