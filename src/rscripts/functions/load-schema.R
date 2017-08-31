library(yaml)
library(plyr)
library(reshape2)

load_schema <- function(x){
    
  #LOAD YAML
  yaml<-yaml.load_file(x)
  
  #LOAD METADATA
  structure <- yaml$Structure
  title <- yaml$Title
  description <- yaml$Description
  landmetrics <- unlist(yaml$Landmetrics)
  aggregation_levels <- unlist(yaml$Aggregations)
  
  #LOAD DATA
  #Unlist the elements of the yaml
  bigTable <- lapply(yaml$Landholders, function(x){ unlist(x)})
  
  #Convert it to a data frame
  bigTable <- rbind.fill(lapply(bigTable, function(x) do.call("data.frame", as.list(x))))
  
  ##Transpose the data frame
  #TODO: REVISAR - Warning message:attributes are not identical across measure variables; they will be dropped
  bigTable <- melt(bigTable, id=c("Landholder"))
  
  #Sort by name
  bigTable <- bigTable[order(bigTable$Landholder),]
  
  #Complete cases to remove rows with NA values BUT,NULL GUESSINGS ARE REMOVED TOO!!!
  bigTable <- bigTable[complete.cases(bigTable),]
  
  #Split Reshape2 variable into "relation_type"."detail"
  bigTable <- data.frame(bigTable$Landholder, bigTable$variable, do.call('rbind', strsplit(as.character(bigTable$variable),'.',fixed=TRUE)), bigTable$value)
  
  #Replace 'Plots' introduced by variable recycling by 0 index
  levels(bigTable$X4) <- c(levels(bigTable$X4), 0)
  bigTable$X4[bigTable$X4 == 'Plots'] <- 0
  #Plot to plot index
  bigTable$X4 <- paste(bigTable$bigTable.Landholder,bigTable$X4, sep = '-')
  
  #Replace numbered variables
  #NeighboursX by "Neighbour"
  levels(bigTable$X3) <- c(levels(bigTable$X3), 'Neighbour')
  bigTable$X3[grepl("Neigh",bigTable$X3)] <- 'Neighbour'
  
  #NaturalX by "Natural"
  levels(bigTable$X3) <- c(levels(bigTable$X3), 'Natural')
  bigTable$X3[grepl("Natur",bigTable$X3)] <- 'Natural'
  
  #AnthropicX by "Anthropic"
  levels(bigTable$X3) <- c(levels(bigTable$X3), 'Anthropic')
  bigTable$X3[grepl("Anthro",bigTable$X3)] <- 'Anthropic'
  
  #AdministrativeX by "Administrative"
  levels(bigTable$X3) <- c(levels(bigTable$X3), 'Administrative')
  bigTable$X3[grepl("Admin",bigTable$X3)] <- 'Administrative'
  
  #bigTable dataframe and names
  bigTable<-data.frame(bigTable$bigTable.Landholder,bigTable$X2,bigTable$X3,bigTable$X4,bigTable$bigTable.value)
  names(bigTable)[1] <- "Landholder"
  names(bigTable)[2] <- "VarCategory"
  names(bigTable)[3] <- "Variable"
  names(bigTable)[4] <- "Plot"
  names(bigTable)[5] <- "Value"
  
  #Append a landholder-based index to the Big Table
  LandholderId<-as.numeric(bigTable$Landholder)
  bigTable<-cbind(LandholderId, bigTable)
  
  #Resulting named list
  result <- setNames(list(
    structure,title,description,landmetrics,aggregation_levels,bigTable), 
    c("structure","title","description","landmetrics","aggregation_levels","bigTable"))
  
  return(result)
}

# CALL IT
#load_schema("/home/benizar/git/capbreu-builder/src/data/capbreu_load_tests_flat.yml","/home/benizar/git/capbreu-builder/builds/output")
