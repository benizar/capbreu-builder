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

base_edge_list <-read.csv(args[1])
flipped_edge_list  <-read.csv(args[2])


# plot relationships between level2 zones
l2_l2.temp<-
  flipped_edge_list %>% 
  filter(value.type=="Neighbours") %>% 
  select(-value.type) %>% 
  inner_join(.,base_edge_list,by=c("value.id","landholder.id")) %>%
  filter(level2.id.x != level2.id.y) %>% 
  select(starts_with("level2.id"))

l2_l2.temp<- 
  unique(data.frame(t(apply(l2_l2.temp,1,sort))))

l2_l2<-
  l2_l2.temp %>% 
  mutate(label="touches",type="level2-border") %>% 
  rename(from="X1",to="X2") %>% 
  select(from,to,label,type) %>% 
  arrange(from)

write.csv(l2_l2, file = args[3])
