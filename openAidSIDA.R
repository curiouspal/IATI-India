sida.activities <- read.csv("./data/sida-activities.csv")

for(i in 1:length(sida.activities$iati.identifier)){
  url <- paste("http://www.openaid.se/activity/", as.character(sida.activities$iati.identifier[i]), sep = "")
  thepage = readLines(url)
  x <- grep("<h2>Documentation</h2>", thepage)
  nextline <- paste(thepage[x+1], thepage[x+2], thepage[x+3])
  sida.activities$docAvailable[i] <- NA
  if(length(grep("We are unable to display documents for this activity.", nextline) == 1)) 
    sida.activities$docAvailable[i] <- "no" 
  if(length(grep("href=\"http://iati.openaid.se/docs/", nextline)==1)) {
    sida.activities$docAvailable[i] <- "yes"
    print(nextline)
    print(i)
  }
}  
summary(as.factor(sida.activities$docAvailable)) 

#write.csv(sida.activities, "./data/SIDAdocAvailable.csv")



url <- paste("http://www.openaid.se/activity/", "SE-0-SE-2-9999108501-GGG-43010", sep = "")
thepage = readLines(url)
x <- grep("<h2>Documentation</h2>", thepage)
x
nextline <- thepage[x+1]
nextline
grep("We are unable to display documents for this activity.", nextline)
length(grep("We are unable to display documents for this activity. Contact Ministry for Foreign Affairs for more information.", nextline))
