library(yaml)
library(reshape2)

yaml<-yaml.load_file("git/capbreu-builder/src/data/capbreu_latest.yml")

# Project data
keeps <- c("Structure","Title","Description")
proj_data <- yaml[keeps]
proj_data<-melt(proj_data)

# Context data
keeps <- c("Landmetrics","Aggregations")
context_data <- yaml[keeps]
context_data<-melt(context_data)

# Schema Data (Schema)
schema_data<-yaml$Landholders
schema_data<-melt(schema_data)

lh_nodes<-schema_data[schema_data$L3 %in% c("Name","LastName","LastName2"),c("L3","value","L2")]
lh_nodes<-dcast(lh_nodes, L2~L3) # Paste labels ommiting NAs

agg1_nodes<-schema_data[schema_data$L6 %in% c("Level_1"),c("L6","value","L2")]
agg1_nodes<-dcast(agg_nodes, value+L2~L6) # Paste labels ommiting NAs

#################

# Move the landholder name from values to its own column 
schema_data<-merge(schema_data,schema_data[schema_data$L2=="Landholder",c("value","L1")],by = "L1")

# Remove NAs
schema_data<-schema_data[complete.cases(schema_data), ]

# Build plot id/name
schema_data$L2<-paste("plot",schema_data$L1,schema_data$L3,sep="-")

# So L3, the plot id is no longer needed
schema_data$L3 <- NULL

# Replace Ls by level names
l1_name<-context_data[which(context_data$L2=="Level_1"), "value"]
l2_name<-context_data[which(context_data$L2=="Level_2"), "value"]

schema_data[which(schema_data$L5=="Level_2"), "L5"] <- l2_name
schema_data[which(schema_data$L5=="Level_1"), "L5"] <- l1_name

# Rename for clarity
names(schema_data) <- c("id_landholder","value","var","var_category","plot", "landholder")


neighbours<-unique(schema_data[which(schema_data$var=="Neighbours"), "value"])