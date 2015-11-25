


unops.activities <- read.csv("./data/unops.csv")

for(i in 1:length(unops.activities$iati.identifier)) {
  unops.activities$docAvailable[i] <- NA
  if(as.character(unops.activities$PROJECT_ID[i]) != as.character(unops.activities$PROJECT_ID[i-1])){
    url <- paste("http://data.unops.org/index.htm#SegmentCode=ORG&FocusCode=DATA_OVERVIEW&EntityCode=PROJECT_ID&EntityValue=000", as.character(unops.activities$PROJECT_ID[i]), "##SectionCode=OVERVIEW", sep = "")
    thepage <- readLines(url)
    n <- NA
    s <- paste('/documents">Documents', sep = "")
    x <- grep(s, thepage)
    n <- as.character(thepage[x])
    n <- as.integer(strsplit(strsplit(n, "\\(")[[1]][2], "\\)")[[1]][1])
    unops.activities$docAvailable[i] <- n
    print(paste("i =", i))
  }
  else unops.activities$docAvailable[i] <- -99
}  
summary(as.factor(unops.activities$docAvailable)) 

#write.csv(unops.activities, "./data/unopsdocAvailable.csv")

library("ggplot2")
b <- subset(unops.activities, docAvailable!=-99)
summary(as.factor(b$docAvailable))

ggplot(b, aes(as.factor(b$docAvailable))) + geom_bar() + xlab("no. of documents")
