library(dplyr)
library(rjson)
library(listviewer)
library(purrr)
library(magrittr)
library(assertthat)
library(tidyjson)

jfile_names <- dir()[1:24]
DF_master <- NULL

for (i in 1:24) {
  jfile <- fromJSON(file = jfile_names[i])
  jfile2 <- jfile$documents

jindex <- rep(TRUE, length(jfile2))
  
for (j in 1:length(jfile2)) {

  if (jfile2[[j]]$documentStatus == "Withdrawn") {
    jindex[j] <- FALSE
  }
  
}    
  
  
  DF<- jfile2 %>% 
    
  {
    
    tibble(
      documentId = map_chr(.[jindex], "documentId", .default = "MISSING VALUE"),
      title = map_chr(.[jindex], "title", .default = "MISSING VALUE"),       
      commentText = map_chr(.[jindex], "commentText", .default = "MISSING VALUE"),
      postedDate = map_chr(.[jindex], "postedDate", .default = "MISSING VALUE")
      )
  }  
  DF_master <- rbind(DF_master, DF)
}



write.csv(DF_master, file = "master file.csv")