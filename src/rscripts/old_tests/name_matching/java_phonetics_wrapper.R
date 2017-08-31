library("rJava")

## Initialize Java
.jinit()
##Check that commons-codec-1.10.jar is in the CLASS_PATH
#.jclassPath()
##If not, add it
.jaddClassPath("commons-codec-1.10.jar")

## Wrapp java functions
cv2 <- .jnew("org.apache.commons.codec.language.Caverphone2")
mrae <- .jnew("org.apache.commons.codec.language.MatchRatingApproachEncoder")
mp <- .jnew("org.apache.commons.codec.language.Metaphone")
dmp <- .jnew("org.apache.commons.codec.language.DoubleMetaphone")
nys <- .jnew("org.apache.commons.codec.language.Nysiis")
refsound <- .jnew("org.apache.commons.codec.language.RefinedSoundex")
sound <- .jnew("org.apache.commons.codec.language.Soundex")
bm <- .jnew("org.apache.commons.codec.language.bm.BeiderMorseEncoder")

caverphone <- function(x) {
  .jcall(cv2,"S","encode", x)  
}

match_rating <- function(x) {
  .jcall(mrae,"S","encode", x)  
}

metaphone <- function(x) {
  .jcall(mp,"S","metaphone", x)  
}

double_metaphone <- function(x) {
  .jcall(dmp,"S","doubleMetaphone", x)  
}

nysiis <- function(x) {
  .jcall(nys,"S","encode", x)  
}

refined_soundex <- function(x) {
  .jcall(refsound,"S","encode", x)  
}

soundex <- function(x) {
  .jcall(sound,"S","encode", x)  
}

beider_morse <- function(x) {
  .jcall(bm,"S","encode", x)  
}