
area_per_l2<-function(x,y){
  
  bigTable<-x$bigTable
  conversion<-x$landmetrics
  Area_unit<-as.character(conversion[1])
  Area_conv<-as.numeric(conversion[2])
  
  ##Subset
  aggregations<-bigTable[bigTable$VarCategory != 'Limits', ]
  ##Reshape
  aggregations<-dcast(aggregations,Landholder+Plot~Variable,value.var = "Value")
  ##Area becomes numeric for first time
  aggregations$Area<-as.numeric(aggregations$Area)
  
  #Units to m2
  aggregations$Area_m2<-aggregations$Area*Area_conv
  
  #Aggregations: area by level_1
  area_by_L1<-aggregate(aggregations$Area, by=list(aggregations$Level_1), FUN=sum, na.rm=TRUE)

  #Order by area
  area_by_L1 <- area_by_L1[order(area_by_L1$x),]

  # Barplots
  pdf(file=y)
  barplot(area_by_L1$x, names.arg=area_by_L1$Group.1, beside = TRUE,las=2,cex.names = 0.65)
  dev.off()
  
}

