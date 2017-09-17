library(yaml)
library(reshape2)

yaml<-yaml.load_file("git/capbreu-builder/src/data/capbreu_latest_fullname.yml")

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

# Move the landholder name from values to its own column 
schema_data<-merge(schema_data,schema_data[schema_data$L2=="Name",c("value","L1")],by = "L1")

# Remove NAs
schema_data<-schema_data[complete.cases(schema_data), ]

# List Neighbours, try to assign an neighbour_id
unique(schema_data[which(apply(schema_data[, -1], MARGIN = 1, function(x) any(x == "Neighbours"))), "value.x"])




# Build plot id/name
schema_data$L2<-paste("plot",schema_data$L1,schema_data$L3,sep="-")
schema_data$L3 <- NULL

# Rename for clarity
names(schema_data) <- c("id_landholder","value","var","var_category","id_plot", "landholder")


# Replace Ls by level names LABELS
l1_name<-context_data[which(context_data$L2=="Level_1"), "value"]
l2_name<-context_data[which(context_data$L2=="Level_2"), "value"]

#schema_data[which(schema_data$L6=="Level_2"), "L6"] <- l2_name
#schema_data[which(schema_data$L6=="Level_1"), "L6"] <- l1_name

# Filter by any (x==People)
#schema_data[which(apply(schema_data[, -1], MARGIN = 1, function(x) any(x == "Level_1"))), ]
agg1<-unique(schema_data[which(apply(schema_data[, -1], MARGIN = 1, function(x) any(x == "Level_1"))), "value"])
agg2<-unique(schema_data[which(apply(schema_data[, -1], MARGIN = 1, function(x) any(x == "Level_2"))), "value"])

natural<-unique(schema_data[which(apply(schema_data[, -1], MARGIN = 1, function(x) any(x == "Natural"))), "value"])
anthropic<-unique(schema_data[which(apply(schema_data[, -1], MARGIN = 1, function(x) any(x == "Anthropic"))), "value"])
administrative<-unique(schema_data[which(apply(schema_data[, -1], MARGIN = 1, function(x) any(x == "Administrative"))), "value"])


# Rename for clarity
names(schema_data) <- c("id_landholder","value","var","var_category","plot", "landholder")


neighbours<-unique(schema_data[which(schema_data$var=="Neighbours"), "value"])