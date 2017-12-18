#datacleaning3

rm(list=ls())

setwd("C:\\Users\\User\\Downloads\\Compressed\\Lynda.R.Statistics.Essential.Training.Full_p30download.com\\Exercise Files\\quiz3")

url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(url = url, destfile = "quiz3.csv")

list.files()

data<-read.csv("quiz3.csv")

head(data)
logic<-data$ACR==3 & data$AGS==6

which(logic)


install.packages("jpeg")
library(jpeg)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", destfile = "quiz2jpeg.jpg")

jpgfile<-readJPEG("quiz2jpeg.jpg", native = TRUE)

quantile(jpgfile, probs = c(0.3,0.8))


library(data.table)
library(dplyr)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile = "quiz3data.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile = "quiz3data2.csv")

q3<-read.csv("quiz3data.csv")
head(q3,n = 20)

