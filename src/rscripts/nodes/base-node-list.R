#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

library(magrittr)
library(yaml)
library(dplyr)
library(tidyr)
library(reshape2) # Reshape lists is not implemented in tidyr


schema_df<-read.csv(args[1])
context_df<-read.csv(args[2])

# Base DataFrame for building different node lists
base_node_list <- 
  schema_df %>% 
  filter(var_category != 'Limits') %>% 
  dcast(landholder.id+landholder.label+
          level1.id+level1.label+
          level2.id+level2.label+
          plot.id+plot.label~
          var,value.var = "value") %>% 
  rename(area="Area") %>% 
  mutate(area=as.numeric(area)) %>% 
  mutate(area_m2=area * as.numeric(select(filter(context_df,key=="Area_Conv"),value)))


write.csv(base_node_list, file = args[3], row.names = FALSE)
