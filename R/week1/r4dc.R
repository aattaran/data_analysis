# chapter 2

#2.1

rm(list=ls())

x<-c(65311, 65624 ,65908, 66219, 66499 ,66821, 67145, 67447)
x<-diff(x)
x

#2.2


bill <- c(46, 33, 39, 37, 46, 30, 48, 32, 49, 35, 30, 48)

which(bill<40)
length(bill[bill<40])
a<-length(bill)
b<-length(which(bill<40))
(b/a)


x <- c(1, 8, 2, 6, 3, 8, 5, 5, 5, 5)

sum(x)/10

log(x, base = 10)

(x-4.4)/2.875

max(x) - min(x)
diff(x)


##########
devtools::install_github("hrbrmstr/omdbapi", force = TRUE)
library(dplyr)
library(pbapply)
library(omdbapi)


search_by_title("Captain America")

ibrary("Simple")

x = c(.314,.289,.282,.279,.275,.267,.266,.265,.256,.250,.249,.211,.161)

hist(x)
rug(x)


#3.1

x <- c(60, 85, 72, 59, 37, 75, 93, 7, 98, 63, 41, 90, 5, 17, 97)
stem(x)
plot(seq(length(x)),x)

hist(x)
rug(x)


x <- rnorm(100)
hist(x)
boxplot(x)

library(UsingR)

data(south)
summary(south)
hist(south)
hist(crime)
hist(aid)


failures <- c(0, 1, 0, NA, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 3, 0, 0, 0, 0, 0, 2, 0, 1)
as.numeric(failures)
failures[is.na(failures)]<-mean(failures, na.rm = TRUE)

mean(failure)
which(is.na(failures))
failures.rm <- function(x) {x[is.na(x)]<-0; x  }
failures
failures.rm

#replace.NA(failures, 0, byRow = TRUE)

table(failures, useNA = 'always')




