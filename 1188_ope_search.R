#install library
install.packages("jsonlite", repos="http://cran.r-project.org")

#load library
library(jsonlite)

#load data set
geo_original <- read.csv('ope-search_preprocess.csv', header=TRUE, stringsAsFactors=F, sep=";", quote="", na.strings="")

geo <- geo_original[c(0:15000),]

for(i in 1:nrow(geo)) {
  params <- fromJSON(geo[i,3])
  for(j in 1:length(params)) {
    param <- params[j]
    currentvalue <- paste(param[1])
    
    if(names(param) == "uir_type") {
      key <- paste0("uir_type_", currentvalue)
      value <- params[j+2][1]
      geo[i, key] <- paste(value)
    } else {
      geo[i, names(param)] <- paste(currentvalue)  
    }    
  }
  
  geo[i, "country"] <- "czech republic"
  print(paste("row:", i))
}

#remove params column 
geo$params <- NULL

write.csv(geo, file = "ope-search_transformed_1.csv", row.names = FALSE, quote=FALSE)