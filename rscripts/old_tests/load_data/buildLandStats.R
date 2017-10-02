
buildLandStats<-function(x){
  
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
  png(filename="your/file/location/name.png")
  barplot(area_by_L1$x, names.arg=area_by_L1$Group.1, beside = TRUE,las=2,cex.names = 0.65)
  dev.off()
  
}

buildLandStats(capbreu)

# ggplot(data=aggregations, aes(x=Landholder, y=Area, fill=Landholder),legend(plot = FALSE)) + geom_bar(stat="identity") + coord_flip() + theme(legend.position="none")
# 
# 
# x <-ggplot(aggregations3, aes(y=Landholder.1, x=Area)) + 
#   geom_point(stat="identity")
# 
# y <-ggplot(aggregations3, aes(x=Landholder.1, y=Area)) + 
#   geom_bar(stat="identity") + 
#   coord_flip()
# 
# grid.arrange(x, y, ncol=2)
# aggregations3 <-aggregations2 <-data.frame(Landholder=rownames(aggregations), aggregations, row.names=NULL)
# aggregations3$Area  <-aggregations2$Area <-as.factor(aggregations2$Area)
# 
# aggregations3$LandholderId <-factor(aggregations2$Landholder, levels=aggregations2[order(aggregations$Area), "LandholderId"])
# 
# 
# ggplot(aggregations, aes(y=Area, x=Landholder)) + 
#   geom_bar(stat="identity") +
#   facet_grid(Level_2~., scales = "free", space="free")+ 
#   coord_flip()