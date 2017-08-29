source("accent.R")
source("soundexES.R")
library("RecordLinkage")

##Compute a phonetics dataframe
word_similarities <- function(a,b) {
  
  phonetics=levenshteinSim(soundexES(a), soundexES(b))
  editdistance=levenshteinSim(a, b)
  
  #   data.frame(
  #     a=a,b=b,similarity=round((editdistance+phonetics)/2,2)
  #   )
  
  return(round((editdistance+phonetics)/2,2))
  
}

##Compare two complete names, all words
phrase_similarities <- function(pa,pb){
  
  paw <- unlist(strsplit(as.character(pa), split=" "))
  pbw <- unlist(strsplit(as.character(pb), split=" "))
  
  
  phrase_result=0
  
  for (a in paw){
    
    word_result=0#Similarity of most similar words
    
    for(b in pbw){
      temp=word_similarities(a,b)
      
      if(temp>word_result)
        word_result=temp
      
    }
    
    phrase_result=phrase_result+word_result
    
  }
  
  #Average phrase similarity
  phrase_result/length(paw)
  
}



kk<-df[df$Variable=='Neighbour', c("Value","Landholder")]

phrase_similarities(neigh$Value[4],neigh$Landholder[4])


##PHONETICS USING RJAVA DEPENDENCIES
# source("java_phonetics_wrapper.R")
# source("accent.R")

# ##Compute a phonetics dataframe for this word
# one_word_phonetics <- function(x) {
#   
#   #We remove all that symbols that cause problems with org.apache.commons.codec.language
#   #This is only necesary if we use the english-based algorithms
#   #xa<-accent(x)
#   
#   data.frame(
#     #caverphone=sapply(x, caverphone),
#     #match_rating=sapply(x, match_rating),
#     #metaphone=sapply(x, metaphone),
#     #double_metaphone=sapply(x, double_metaphone),
#     #nysiis=sapply(x, nysiis),
#     #refined_soundex=sapply(x, refined_soundex),
#     #soundex=sapply(x, soundex),
#     #beider_morse=sapply(x, beider_morse),
#     soundexES=sapply(x,soundexES)
#   )
# }