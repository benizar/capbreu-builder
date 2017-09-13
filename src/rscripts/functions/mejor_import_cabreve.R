library(yaml)
library(reshape2)

yaml<-yaml.load_file("src/data/capbreu_load_tests_flat.yml")

# Metadata needed for operations
metadata<-yaml
metadata$Landholders<-NULL

# Schema Data
data<-yaml$Landholders

# Vertical shape
data<-melt(data, id=c(Landholders))
metadata<-melt(metadata)


# Move the landholder name from values to its own column 
data<-merge(data,data[data$L2=="Landholder",c("value","L1")],by = "L1")

# Remove NAs
data<-merged[complete.cases(data), ]

# Build plot id/name
data$L2<-paste("plot",data$L1,data$L3,sep="-")

# So L3, the plot id is no longer needed
data$L3 <- NULL

# Replace Ls by level names
l1_name<-metadata[which(metadata$L2=="Level_1"), "value"]
l2_name<-metadata[which(metadata$L2=="Level_2"), "value"]

data[which(data$L5=="Level_2"), "L5"] <- l2_name
data[which(data$L5=="Level_1"), "L5"] <- l1_name





# Rename for clarity
names(data) <- c("id_landholder","value","var","var_category","plot", "landholder")


neighbours<-unique(data[which(data$var=="Neighbours"), "value"])
