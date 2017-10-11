#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

plot_level1 <- function(input.csv, output.csv){
  
  library(dplyr)

  base_edge_list<-read.csv(input.csv)
  
  plot_level1<-
    base_edge_list %>% 
    select(plot.id,level1.id) %>%
    distinct() %>% 
    rename(from="plot.id",to="level1.id") %>% 
    mutate(label="belongs to",type="plot-level1-part") %>% 
    select(from,to,label,type) %>% 
    arrange(from)
  
  write.csv(plot_level1, file = output.csv, row.names = FALSE)
  
}

suppressWarnings(
  suppressMessages(
    plot_level1(args[1],args[2])
  )
)
