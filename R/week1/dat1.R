rm(list=ls())

url<-"https://aqs.epa.gov/aqsweb/airdata/annual_aqi_by_county_2017.zip"



download.file(url = url, destfile = "air.zip")
list.files()

air<-unzip("air.zip")
air<-read.csv("./annual_aqi_by_county_2017.csv")

head(air)

names(air)

library(nlme)
library(lattice)
xyplot(weight ~ Time | Diet, BodyWeight)

seq_along(4)

x<-c(65311, 65624 ,65908, 66219, 66499 ,66821, 67145, 67447)
x<-diff(x)
x
