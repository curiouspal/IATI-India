dfid.activities <- read.csv("./data/dfid.csv")

for(i in 1:length(dfid.activities$iati.identifier)) {
  dfid.activities$docAvailable[i] <- NA
  if(as.character(dfid.activities$iati.identifier[i]) == paste("GB-1-", strsplit(as.character(dfid.activities$iati.identifier[i]), "-")[[1]][3], sep="")){
    url <- paste("http://devtracker.dfid.gov.uk/projects/GB-1-", strsplit(as.character(dfid.activities$iati.identifier[i]), "-")[[1]][3], sep = "")
    thepage <- readLines(url)
    n <- NA
    s <- paste('/documents">Documents', sep = "")
    x <- grep(s, thepage)
    n <- as.character(thepage[x])
    n <- as.integer(strsplit(strsplit(n, "\\(")[[1]][2], "\\)")[[1]][1])
    dfid.activities$docAvailable[i] <- n
    print(paste("i =", i))
  }
  else dfid.activities$docAvailable[i] <- -99
}  
summary(as.factor(dfid.activities$docAvailable)) 

#write.csv(dfid.activities, "./data/dfiddocAvailable.csv")

library("ggplot2")
b <- subset(dfid.activities, docAvailable!=-99)
summary(as.factor(b$docAvailable))

ggplot(b, aes(as.factor(b$docAvailable))) + geom_bar() + xlab("no. of documents")
