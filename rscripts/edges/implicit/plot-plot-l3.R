#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

plot_plot_l3 <- function(base_edge_list.csv, flipped_edge_list.csv, plot_plot_l3.csv){
  
  library(magrittr)
  library(dplyr)
  library(tidyr)
  
  base_edge_list <-read.csv(base_edge_list.csv)
  flipped_edge_list  <-read.csv(flipped_edge_list.csv)
  
  
  # TODO: read variables from file instead of calculating again here...
  #plot_plot_l1.temp<-read.csv(args[3])
  
  plot_plot_l1.temp<-
    flipped_edge_list %>% 
    filter(value.type=="Neighbours") %>% 
    select(-value.type) %>% 
    inner_join(.,base_edge_list,by=c("value.id","landholder.id","level1.id","level2.id")) %>%
    filter(plot.id.x != plot.id.y) %>% 
    select(starts_with("plot.id"))
  
  plot_plot_l1.temp<- 
    unique(data.frame(t(apply(plot_plot_l1.temp,1,sort))))
  
  
  # Neighbour plots within the same level2, but not same level1
  plot_plot_l2.temp<-
    flipped_edge_list %>% 
    filter(value.type=="Neighbours") %>% 
    select(-value.type) %>% 
    inner_join(.,base_edge_list,by=c("value.id","landholder.id","level2.id")) %>%
    filter(plot.id.x != plot.id.y) %>% 
    select(starts_with("plot.id"))
  
  plot_plot_l2.temp<-
    unique(data.frame(t(apply(plot_plot_l2.temp,1,sort)))) %>% 
    setdiff(plot_plot_l1.temp)
  
  
  
  
  # Neighbour plots at different l1 and l2
  plot_plot_l3.temp<-
    flipped_edge_list %>% 
    filter(value.type=="Neighbours") %>% 
    select(-value.type) %>% 
    inner_join(.,base_edge_list,by=c("value.id","landholder.id")) %>%
    filter(plot.id.x != plot.id.y) %>% 
    select(starts_with("plot.id"))
  
  plot_plot_l3.temp<-
    unique(data.frame(t(apply(plot_plot_l3.temp,1,sort)))) %>% 
    setdiff(plot_plot_l1.temp) %>%
    setdiff(plot_plot_l2.temp)
  
  plot_plot_l3<-
    plot_plot_l3.temp %>% 
    mutate(label="touches",type="plot-border-l2") %>% 
    rename(from="X1",to="X2") %>% 
    select(from,to,label,type) %>% 
    arrange(from)
  
  write.csv(plot_plot_l3, file = args[3], row.names = FALSE)
  
}

suppressWarnings(
  suppressMessages(
    plot_plot_l3(args[1],args[2],args[3])
  )
)
