# Remove spaces for DOT
sanitize <- function(x){
	tolower(iconv(gsub(" ", "-", x),to="ASCII//TRANSLIT"))
}
