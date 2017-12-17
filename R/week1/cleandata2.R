#datacleaning2

rm(list=ls())

library(httr)

oauth_endpoints("github")

myapp <- oauth_app("github",
                   key = "a0f6af46e1e2ef365218",
                   secret = "78517fefb5bf4884e191a431fe8496321adbe57d")

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

gtoken <- config(token = github_token)
req <- GET("https://api.github.com/rate_limit", gtoken)
stop_for_status(req)
content(req)


install.packages("jsonlite")

library(jsonlite)
require("jsonlite")
json1 = content(req)
json2 = jsonlite::fromJSON(toJSON(json1))
repo <- json2[5]
names(repo)


install.packages("sqldf")

library(sqldf)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "quiz2data.csv")
acs <- read.csv("quiz2data.csv")
head(acs)

sqldf("select pwgtp1 from acs where AGEP < 50")

