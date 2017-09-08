#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}


# FUNCTIONS
reshape_bigtable<-function(bigTable, area_conv){

  library(reshape2)

  ##Subset, reshape and convert area to m2
  reshaped<-bigTable[bigTable$VarCategory != 'Limits', ]
  reshaped<-dcast(reshaped,Landholder+Plot~Variable,value.var = "Value")
  reshaped$Area<-as.numeric(reshaped$Area)
  reshaped$Area_m2<-reshaped$Area*area_conv

  reshaped
}

# TASKS

bigTable<-read.csv(args[1])

reshaped<-reshape_bigtable(bigTable,10)

write.csv(reshaped, file = args[2])
