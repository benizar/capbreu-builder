#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}

#source("sanitize.R")

# Libraries and functions
library(yaml)

sanitize <- function(x){
	tolower(iconv(gsub(" ", "-", x),to="ASCII//TRANSLIT"))
}

get_landholders_list <- function(x){

	yaml = yaml.load_file(x)

	landholders_list = c()

	for(i in yaml$Landholders){
		landholders_list = c(landholders_list,sanitize(i$Landholder))
	}

	landholders_list

}

write_landholders_list <- function(x,y){
	fileConn<-file(y)
	writeLines(x, fileConn)
	close(fileConn)
}

# Call
write_landholders_list(get_landholders_list(args[1]),args[2])

