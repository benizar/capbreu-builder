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

landholder_plots_rules <- function(x){

	yaml = yaml.load_file(x)

	landholder_plots_rules=c()

	for(lh in yaml$Landholders){
		
		landholder=sanitize(lh$Landholder)
		landholder_plots=c()

		p_count=1
		for(p in lh$Plots){
			landholder_plots=c(landholder_plots,paste(landholder,p_count,sep="-"))
			p_count=p_count+1 # plot counter
		}

		landholder_plots=paste(landholder_plots,collapse=" ")
		landholder_plots_rules=c(landholder_plots_rules,paste(landholder,": ",landholder_plots,sep=""))
	}

	landholder_plots_rules

}

write_rules <- function(x,y){
	fileConn<-file(y)
	writeLines(x, fileConn)
	close(fileConn)
}

# Call
write_rules(landholder_plots_rules(args[1]),args[2])

