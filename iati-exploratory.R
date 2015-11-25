data <- read.csv("./data/IndiaAid.csv")
data <- subset(data, recipient.country.code == "IN")
#cola <- subset(data, "Coca Cola India Pvt Ltd." %in% participating.org..Funding.)
summary(data)

dfid <- subset(data, transaction_provider.org=="Department for International Development")
summary(dfid)
sum(dfid$transaction.value)
summary(as.factor(dfid$transaction_receiver.org))

summary(as.factor(tolower(data$transaction_receiver.org)))

summary(as.factor(tolower(data$transaction_provider.org)))

summary(as.factor(tolower(data$participating.org..Accountable.)))

summary(as.factor(tolower(data$participating.org.type..Accountable.)))

summary(as.factor(tolower(data$reporting.org.type)))

summary(as.factor(tolower(data$participating.org.type..Funding.)))

summary(as.factor(tolower(data$participating.org.ref..Funding.)))

summary(as.factor(tolower(data$participating.org..Funding.)))


x = subset(data, transaction_receiver.org=="International Institute for Environment and Development")
x$description



##########################################################

unh <- read.csv("./data/transaction-unh.csv")

summary(unh)
unh$title

unh_in <- subset(unh, recipient.country.code=="IN")
summary(unh_in)

intersect(names(data), names(unh))
