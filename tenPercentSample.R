unh.activities <- read.csv("./data/unh-activities.csv")

for(i in 1:length(unh.activities$iati.identifier)){
  url <- paste("http://open.unhabitat.org/project/", as.character(unh.activities$iati.identifier[i]), "/", sep = "")
  thepage = readLines(url)
  x <- grep("<h2>Document</h2>", thepage)
  nextline <- thepage[x:x+1]
  unh.activities$docAvailable[i] <- NA
  if(length(grep("No documents available", nextline) == 1)) 
    unh.activities$docAvailable[i] <- "no" 
  if(length(grep("href", nextline)==1))
    unh.activities$docAvailable[i] <- "yes"
}  
summary(as.factor(unh.activities$docAvailable)) 
#write.csv(unh.activities, "./data/docAvailable.csv")

##########################################################3

for(i in 1:length(unh.activities$iati.identifier)){
  url <- paste("http://open.unhabitat.org/project/", as.character(unh.activities$iati.identifier[i]), "/", sep = "")
  thepage = readLines(url)
  #x <- grep("Back to results</a>", thepage)
  #thepage <- thepage[x+1:length(thepage)]
  unh.activities$resultAvailable[i] <- NA
  if(length(grep("<h2>Results</h2>", thepage)) >= 1){
    unh.activities$resultAvailable[i] <- "yes"
    print(grep("<h2>Results</h2>", thepage))
    print(url)
  } 
  else unh.activities$resultAvailable[i] <- "no"
}  
summary(as.factor(unh.activities$resultAvailable)) 
#write.csv(unh.activities, "./data/docAvailable.csv")

##########################################################3
library("ggplot2")

unh.activities <- read.csv("./data/docAvailable.csv")

for(k in 1:length(unh.activities$end.planned))
  unh.activities$end.year[k] <- substr(as.character(unh.activities$end.planned[k]), 1, 4)

unh.activities$end.year <- as.factor(unh.activities$end.year)
summary(unh.activities$end.year)
  

ggplot(unh.activities, aes(end.year)) + geom_bar(aes(fill=docAvailable)) + xlab("Year in which project is planned to end")
# The above graph shows that the earlier projects are more likely to have the documentation on open.unhabitat.org than the later projects.
unh.activities$log.incoming.funds <- log(unh.activities$total.Incoming.Funds)
ggplot(unh.activities, aes(factor(docAvailable), log.incoming.funds)) + geom_boxplot(position="dodge", aes(fill=docAvailable)) + xlab("docAvailable")

################################################################3
# Set seed for reproducibility
set.seed(10)

# Select 38 random projects from the above dataframe.
sample <- unh.activities[sample(nrow(unh.activities), 38), ] 
sample <- sample[c("iati.identifier", "title", "recipient.country", "total.Incoming.Funds", "end.planned", "docAvailable")]
#write.csv(sample, "./data/tenPercentSample.csv")
