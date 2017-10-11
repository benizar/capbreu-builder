#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

base_node_list <- function(schema.csv, context.csv, base_node_list.csv){
  
  library(dplyr)
  library(reshape2) # Reshape lists is not implemented in rstudio's tidyr
  
  
  schema<-read.csv(schema.csv)
  context<-read.csv(context.csv)
  
  # Base DataFrame for building different node lists
  base_node_list <- 
    schema %>% 
    filter(var_category != 'Limits') %>% 
    dcast(landholder.id+landholder.label+
            level1.id+level1.label+
            level2.id+level2.label+
            plot.id+plot.label~
            var,value.var = "value") %>% 
    rename(area="Area") %>% 
    mutate(area=as.numeric(area)) %>% 
    mutate(area_m2=area * as.numeric(select(filter(context,key=="Area_Conv"),value)))
  
  
  write.csv(base_node_list, file = base_node_list.csv, row.names = FALSE)
  
}

suppressWarnings(
  suppressMessages(
    base_node_list(args[1],args[2],args[3])
  )
)
