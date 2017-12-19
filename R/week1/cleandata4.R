#datacleaning4

rm(list=ls())
setwd("C:\\Users\\User\\Downloads\\Compressed\\Lynda.R.Statistics.Essential.Training.Full_p30download.com\\Exercise Files\\quiz4")

url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(url = url, destfile = "quiz4.csv")

list.files()

data<-read.csv("quiz4.csv")
head(data)
names(data)
strsplit(names(data), split = "wgtp")[123]



download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile = "quiz4data.csv")
data <- read.csv("quiz4data.csv")

names(data)

clean<- gsub(",","",data[,5])

head(data[,4])

head(clean,10)

class(clean)
clean<-as.numeric(clean)
mean(clean,na.rm = TRUE)

grep( "^United",data[,4])

data[c(5,10,36),4]



download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile = "quiz4data2.csv")

data2 <- read.csv("quiz4data2.csv")

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile = "quiz4data3.csv")

data3 <- read.csv("quiz4data3.csv")

head(data2)

setnames(data2, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))

alldata<-merge(data2,data3, by = "CountryCode")

head(alldata)

grep("water.*", names(alldata))

alldata[,36]

head(alldata$Special.Notes)

table(grepl("june", tolower(alldata$Special.Notes)), grepl("fiscal year end", tolower(alldata$Special.Notes)))




install.packages("quantmod")
library(quantmod)


amazon <-getSymbols("AMZN", auto.assign = FALSE)

sampletimes <- index(amazon)
length(sampletimes)


length(grep("^2012",sampletimes))
