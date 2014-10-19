#install library
install.packages("RJSONIO", repos="http://cran.r-project.org")

#load library
library(RJSONIO)
library(plyr)

#load data set
geo.original <- read.csv('ope-search_preprocess.csv', header=TRUE, stringsAsFactors=F, sep=";", quote="", na.strings="")

geo.original[is.na(geo.original)] <- ""

#add additional information for geolocation
geo.original[, "country"] <- "czech republic"

geo.final <- ddply(geo.original, 'id', function(row) {
  json.parsed <- fromJSON(row[,3])
  
  for(j in 1:length(json.parsed)) {
    param <- json.parsed[j]
    current.value <- paste(param[1])
    
    column.name <- names(param)
    
    if(column.name == "uir_type") {
      key <- paste0("uir_type_", current.value)
      value <- paste(json.parsed[j+2][1])
    } else {
      key <- column.name
      value <- paste(current.value)
    }
    
    row[,key] <- value     
  }
 
  return(row)  
}) 

#remove params column 
geo.final$params <- NULL

write.csv(geo.final, file = "ope-search_transformed.csv", row.names = FALSE, quote=TRUE)