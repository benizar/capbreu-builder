library(yaml)
library(reshape2)

yaml<-yaml.load_file("src/data/capbreu_latest_fullname.yml")

# Project data
proj_data <- yaml[c("Structure","Title","Description")]
proj_data<-melt(proj_data)
names(proj_data)<-c("value","var")

# Context data
context_data <- yaml[c("Landmetrics","Aggregations")]
context_data<-melt(context_data)
names(context_data)<-c("value","var","var_category")

# Schema Data (Schema)
schema_data<-yaml$Landholders
schema_data<-melt(schema_data)
names(schema_data) <- c("value","var","var_category","id_plot","name_plot", "id_landholder")

# Move the landholder name from values to its own column 
schema_data <- merge(schema_data,schema_data[schema_data$name_plot=="Name",c("value","id_landholder")],by = "id_landholder")
schema_data <- schema_data[complete.cases(schema_data), ]
names(schema_data) <- c("id_landholder","value","var","var_category","id_plot","name_plot","name")

# Build plot id/name
schema_data$id_plot<-paste("plot",schema_data$id_landholder,schema_data$id_plot,sep="-")
schema_data$name_plot <- NULL

# Transpose level 2
schema_data<-merge(schema_data[schema_data$var=="Level_2",c("id_plot","value")],schema_data, by="id_plot")
names(schema_data)<-c("id_plot", "level_2","id_landholder","value","var","var_category","name")
schema_data<-schema_data[!(schema_data$var=="Level_2"),]


# Transpose level 1
schema_data<-merge(schema_data[schema_data$var=="Level_1",c("id_plot","value")],schema_data, by="id_plot")
names(schema_data)<-c("id_plot", "level_1", "level_2", "id_landholder","value","var","var_category","name")
schema_data<-schema_data[!(schema_data$var=="Level_1"),]


# Replace Ls by level names LABELS
l1_name<-context_data[which(context_data$var=="Level_1"), "value"]
l2_name<-context_data[which(context_data$var=="Level_2"), "value"]
#schema_data[which(schema_data$var=="Level_2"), "var"] <- l2_name
#schema_data[which(schema_data$var=="Level_1"), "var"] <- l1_name

# Area aggregations
schema_data_aggregates <- schema_data[schema_data$var_category != 'Limits', ]
schema_data_aggregates <- dcast(schema_data_aggregates,name+id_landholder+level_1+level_2+id_plot~var,value.var = "value")
schema_data_aggregates$Area <- as.numeric(schema_data_aggregates$Area)
schema_data_aggregates$Area_m2 <- schema_data_aggregates$Area*as.numeric(context_data[context_data$var=="Area_Conv","value"])

landholders <- aggregate(schema_data_aggregates$Area_m2, by=list(schema_data_aggregates$id_landholder,schema_data_aggregates$name), FUN=sum, na.rm=TRUE)
colnames(landholders) <- c('id', 'name', 'area')

agg1<-aggregate(schema_data_aggregates$Area_m2, by=list(schema_data_aggregates$level_1), FUN=sum, na.rm=TRUE)
colnames(agg1) <- c('name', 'area')
agg1<-data.frame(id = seq(from = 1, to = length(agg1$name)),
                 name = agg1$name,
                 area = agg1$area)

agg2<-aggregate(schema_data_aggregates$Area_m2, by=list(schema_data_aggregates$level_2), FUN=sum, na.rm=TRUE)
colnames(agg2) <- c('name', 'area')
agg2<-data.frame(id = seq(from = 1, to = length(agg2$name)),
                 name = agg2$name,
                 area = agg2$area)


#################
# Other limits lists
natural <- unique(schema_data[which(schema_data$var=="Natural"),c("value")])
natural <- data.frame(id = seq(from = 1, to = length(natural)),
                    name = natural)

anthropic <- unique(schema_data[which(schema_data$var=="Anthropic"),c("value")])
anthropic<-data.frame(id = seq(from = 1, to = length(anthropic)),
                    name = anthropic)

administrative <- unique(schema_data[which(schema_data$var=="Administrative"),c("value")])
administrative <- data.frame(id = seq(from = 1, to = length(administrative)),
                      name = administrative)

# Just neighbours list
neighbours<-data.frame(name=unique(schema_data[which(schema_data$var=="Neighbours"), c("value")]))
just_neighbours<-setdiff(neighbours$name,landholders$name)
just_neighbours<-data.frame(id = seq(from = max(landholders$id), length.out = length(just_neighbours)),
                            name = just_neighbours)
# Neighbours with ids (landholders + justneighbours)
neighbours<-data.frame(id=c(landholders$id,just_neighbours$id),
                  name=c(landholders$name,as.character(just_neighbours$name)))
