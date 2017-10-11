#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

plot_anthropic <- function(input.csv, output.csv){
  
  library(dplyr)

  base_edge_list<-read.csv(input.csv)
  
  plot_anthropic<-
    base_edge_list %>% 
    filter(value.type=="Anthropic") %>%
    select(plot.id,value.id) %>%
    distinct() %>% 
    rename(from="plot.id",to="value.id") %>% 
    mutate(label="touches",type="plot-anthropic-border") %>% 
    select(from,to,label,type) %>% 
    arrange(from)
  
  write.csv(plot_anthropic, file = output.csv, row.names = FALSE)
  
}

suppressWarnings(
  suppressMessages(
    plot_anthropic(args[1],args[2])
  )
)
