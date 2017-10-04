#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

level1_level1 <- function(base_edge_list.csv, flipped_edge_list.csv, level1_level1.csv){
  
  library(magrittr)
  library(dplyr)
  library(tidyr)
  
  base_edge_list <-read.csv(base_edge_list.csv)
  flipped_edge_list  <-read.csv(flipped_edge_list.csv)
  
  
  # Implicit relationships between level1 zones
  level1_level1.temp<-
    flipped_edge_list %>% 
    filter(value.type=="Neighbours") %>% 
    select(-value.type) %>% 
    inner_join(.,base_edge_list,by=c("value.id","landholder.id")) %>%
    filter(level1.id.x != level1.id.y) %>% 
    select(starts_with("level1.id"))
  
  level1_level1.temp<- 
    unique(data.frame(t(apply(level1_level1.temp,1,sort))))
  
  level1_level1<-
    level1_level1.temp %>% 
    mutate(label="touches",type="level1-border") %>% 
    rename(from="X1",to="X2") %>% 
    select(from,to,label,type) %>% 
    arrange(from)
  
  write.csv(level1_level1, file = level1_level1.csv, row.names = FALSE)
  
}

suppressWarnings(
  suppressMessages(
    level1_level1(args[1],args[2],args[3])
  )
)


