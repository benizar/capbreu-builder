#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

schema <- function(input.yaml, output.csv){
  
  library(yaml)
  library(dplyr)
  library(tidyr)
  library(reshape2) # Reshape lists is not implemented in rstudio's tidyr
  
  yaml <- yaml.load_file(input.yaml)
  
  # Base DataFrame for nodes and edges
  schema <-
    yaml %$% 
    Landholders %>%
    melt() %>%
    left_join(.,filter(select(.,value,L1,L2),L2=="Name"), by="L1") %>%
    select(-starts_with("L2")) %>% 
    drop_na() %>%
    unite(plot.id, L1, L3, sep = "-", remove = FALSE) %>% 
    select(-L3) %>% 
    left_join(.,filter(select(.,plot.id,L5,value.x),L5=="Level_1"), by="plot.id") %>%
    select(-L5.y) %>% 
    left_join(.,filter(select(.,plot.id,L5.x,value.x.x),L5.x=="Level_2"), by="plot.id") %>%
    select(-L5.x.y) %>% 
    filter(L4!="Aggregations") %>% 
    rename(value="value.x.x.x",var="L5.x.x",var_category="L4",landholder.id="L1", 
           landholder.label="value.y", level1.label="value.x.y", level2.label="value.x.x.y") %>% 
    mutate(plot.label=paste(landholder.label,plot.id,sep="-"),
           plot.id=paste("P",plot.id,sep="-"),
           landholder.id=paste("LH",landholder.id,sep="-"))
  
  # Add ids
  schema$level1.id <- 
    schema %>% 
    group_indices(level1.label) %>% 
    paste("LEVA",.,sep="-")
  
  schema$level2.id <- 
    schema %>% 
    group_indices(level2.label) %>% 
    paste("LEVB",.,sep="-")
  
  # Order columns
  schema<-
    schema %>% 
    select(value, var, var_category,
           landholder.id, landholder.label,
           plot.id, plot.label,
           level1.id, level1.label,
           level2.id, level2.label)
  
  
  write.csv(schema, file = output.csv, row.names = FALSE)
  
}

suppressWarnings(
  suppressMessages(
    schema(args[1],args[2])
  )
)
