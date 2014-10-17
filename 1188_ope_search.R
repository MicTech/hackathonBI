#install library
install.packages("jsonlite", repos="http://cran.r-project.org")

#load library
library(jsonlite)

#load data set
geo <- read.csv('1188_ope_search.csv', header=TRUE, stringsAsFactors=F, sep=";", quote="")

for(i in 1:nrow(geo)) {
  params <- fromJSON(geo[i,3])
  for(j in 1:length(params)) {
    param <- params[j]
    print(paste("i:", i, "key:", names(param), "value:", param[1]))
    geo[i, names(param)] <- paste(param[1])
  }
}

#remove params column 
geo$params <- NULL

write.csv(geo, file = "1188_ope_search_transformed.csv", row.names = FALSE)