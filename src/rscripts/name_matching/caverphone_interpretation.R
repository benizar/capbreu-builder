caverphonise <- function(x) {
  # Convert to lowercase
  x <- tolower(x)
  
  # Remove anything not A-Z
  x <- gsub("[^a-z]", "", x)
  
  # If the name starts with
  ## cough make it cou2f
  x <- gsub("^cough", "cou2f", x)
  ## rough make it rou2f
  x <- gsub("^rough", "rou2f", x)
  ## tough make it tou2f
  x <- gsub("^tough", "tou2f", x)
  ## enough make it enou2f
  x <- gsub("^enough", "enou2f", x)
  ## gn make it 2n
  x <- gsub("^gn", "2n", x)
  
  # If the name ends with
  ## mb make it m2
  x <- gsub("mb$", "m2", x)
  
  # Replace
  ## cq with 2q
  x <- gsub("cq", "2q", x)
  ## ci with si
  x <- gsub("ci", "si", x)
  ## ce with se
  x <- gsub("ce", "se", x)
  ## cy with sy
  x <- gsub("cy", "sy", x)
  ## tch with 2ch
  x <- gsub("tch", "2ch", x)
  ## c with k
  x <- gsub("c", "k", x)
  ## q with k
  x <- gsub("q", "k", x)
  ## x with k
  x <- gsub("x", "k", x)
  ## v with f
  x <- gsub("v", "f", x)
  ## dg with 2g
  x <- gsub("dg", "2g", x)
  ## tio with sio
  x <- gsub("tio", "sio", x)
  ## tia with sia
  x <- gsub("tia", "sia", x)
  ## d with t
  x <- gsub("d", "t", x)
  ## ph with fh
  x <- gsub("ph", "fh", x)
  ## b with p
  x <- gsub("b", "p", x)
  ## sh with s2
  x <- gsub("sh", "s2", x)
  ## z with s
  x <- gsub("z", "s", x)
  ## any initial vowel with an A
  x <- gsub("^[aeiou]", "A", x)
  ## all other vowels with a 3
  x <- gsub("[aeiou]", "3", x)
  ## 3gh3 with 3kh3
  x <- gsub("3gh3", "3kh3", x)
  ## gh with 22
  x <- gsub("gh", "22", x)
  ## g with k
  x <- gsub("g", "k", x)
  ## groups of the letter s with a S
  x <- gsub("s+", "S", x)
  ## groups of the letter t with a T
  x <- gsub("t+", "T", x)
  ## groups of the letter p with a P
  x <- gsub("p+", "P", x)
  ## groups of the letter k with a K
  x <- gsub("k+", "K", x)
  ## groups of the letter f with a F
  x <- gsub("f+", "F", x)
  ## groups of the letter m with a M
  x <- gsub("m+", "M", x)
  ## groups of the letter n with a N
  x <- gsub("n+", "N", x)
  ## w3 with W3
  x <- gsub("w3", "W3", x)
  ## wy with Wy
  x <- gsub("wy", "Wy", x)
  ## wh3 with Wh3
  x <- gsub("wh3", "Wh3", x)
  ## why with Why
  x <- gsub("why", "Why", x)
  ## w with 2
  x <- gsub("w", "2", x)
  ## any initial h with an A
  x <- gsub("^h", "A", x)
  ## all other occurrences of h with a 2
  x <- gsub("h", "2", x)
  ## r3 with R3
  x <- gsub("r3", "R3", x)
  ## ry with Ry
  x <- gsub("ry", "Ry", x)
  ## r with 2
  x <- gsub("r", "2", x)
  ## l3 with L3
  x <- gsub("l3", "L3", x)
  ## ly with Ly
  x <- gsub("ly", "Ly", x)
  ## l with 2
  x <- gsub("l", "2", x)
  ## j with y
  x <- gsub("j", "y", x)
  ## y3 with Y3
  x <- gsub("y3", "Y3", x)
  ## y with 2
  x <- gsub("y", "2", x)
  
  # remove all
  ## 2s
  x <- gsub("2", "", x)
  ## 3s
  x <- gsub("3", "", x)
  # put six 1s on the end
  x <- paste(x,"111111", sep="")
  # take the first six characters as the code
  unlist(lapply(x, FUN= function(x){paste((strsplit(x, "")[[1]])[1:6], collapse="")}))
}