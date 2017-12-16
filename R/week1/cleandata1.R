#datacleaning1

rm(list=ls())
setwd("C:\\Users\\User\\Downloads\\Compressed\\Lynda.R.Statistics.Essential.Training.Full_p30download.com\\Exercise Files\\quiz3")
urlf<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url =urlf ,destfile = "idaho_housing.cvs")

list.files()

dateDownloaded <- date()
dateDownloaded

idaho_housing<-read.csv("idaho_housing.cvs")
head(idaho_housing)

str(idaho_housing)

summary(idaho_housing)

(idaho_housing$VAL==24)

idaho_housing$VAL[idaho_housing$VAL==24 & !is.na(idaho_housing$VAL)]


length(idaho_housing$VAL[idaho_housing$VAL==24 & !is.na(idaho_housing$VAL)])


urlf2<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"

download.file(url = urlf2, destfile = "gov.xlsx", mode = "wb")


list.files()
#install.packages("xlsx")
library(xlsx)
rowIndex <- 18:23
colIndx <- 7:15
dat <- read.xlsx(file="gov.xlsx",sheetIndex=1,colIndex=colIndx,startRow=18, endRow=23, header=TRUE)
head(dat)
sum(dat$Zip*dat$Ext,na.rm=T)

install.packages("XML")
library(XML)
library(RCurl)
urlf3<- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"

#download.file(url = urlf3, destfile = "restaurants.xml", mode = "wb")

list.files()
doc<-xmlTreeParse(sub("s","",urlf3), useInternal = TRUE )

rootNode<-xmlRoot(doc)
xmlName(rootNode)
names(rootNode)

rootNode[[1]][[1]]

zipcode<- xpathApply(rootNode,"//zipcode",xmlValue)
length(zipcode[zipcode==21231])



install.packages("RMySQL")
library(RMySQL)


ucscDb <- dbConnect(MySQL(),user="genome", 
                    host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb,"show databases;"); dbDisconnect(ucscDb);

result


hg19 <- dbConnect(MySQL(),user="genome", db = "hg19",
                    host="genome-mysql.cse.ucsc.edu")

allTables<-dbListTables(hg19)
length(allTables)

allTables[1:5]
dbGetQuery(hg19, "select count(*) from affyU133Plus2")
dbListFields(hg19,"affyU133Plus2")


dbGetQuery(hg19, "select count(*) from affyU133Plus2")
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)


query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")


affyMis <- fetch(query); quantile(affyMis$misMatches)



affyMisSmall <- fetch(query,n=10); dbClearResult(query);

dim(affyMisSmall)


dbDisconnect(hg19)
