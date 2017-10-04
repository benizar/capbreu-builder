#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

level2_level2 <- function(base_edge_list.csv, flipped_edge_list.csv, level2_level2.csv){
  
  library(magrittr)
  library(dplyr)
  library(tidyr)
  
  base_edge_list <-read.csv(base_edge_list.csv)
  flipped_edge_list  <-read.csv(flipped_edge_list.csv)
  
  # Implicit relationships between level2 zones
  level2_level2.temp<-
    flipped_edge_list %>% 
    filter(value.type=="Neighbours") %>% 
    select(-value.type) %>% 
    inner_join(.,base_edge_list,by=c("value.id","landholder.id")) %>%
    filter(level2.id.x != level2.id.y) %>% 
    select(starts_with("level2.id"))
  
  level2_level2.temp<- 
    unique(data.frame(t(apply(level2_level2.temp,1,sort))))
  
  level2_level2<-
    level2_level2.temp %>% 
    mutate(label="touches",type="level2-border") %>% 
    rename(from="X1",to="X2") %>% 
    select(from,to,label,type) %>% 
    arrange(from)
  
  write.csv(level2_level2, file = level2_level2.csv, row.names = FALSE)
  
}

suppressWarnings(
  suppressMessages(
    level2_level2(args[1],args[2],args[3])
  )
)

