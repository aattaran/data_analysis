#

for(i in 1:100) 
  print(primes[i])

for(i in primes) print(i)

simple.sim(1000,f,100,.5)

n = 10
p = .25
hist(rbinom(100,n,p), breaks=seq(0,6,1), col=gray(.9), prob=T)
lines(seq(0,6,1), dbinom(seq(0,6,1), n, p), col='green')

dev.off()


set.seed(8.4)
par(mfrow=c(3,1), oma=c(0,0,2,0))
boxplot(rt(100,5), horizontal=T, main="rt(100, df=2)")
boxplot(rt(100,10), horizontal=T, main="rt(100, df=10)")
boxplot(rt(100,25), horizontal=T, main="rt(100, df=25)")
title("8.4 - Comparison of t-distribution and DF", outer=T)




set.seed(9.1)
mu = 10
sd = 5

x <- rnorm(15, mu, sd)
simple.eda(x)


xbar <- mean(x)
se   <- sd/sqrt(length(x))

z <- (xbar - mu) / se
z
data(package='UsingR', exec.pay)

wilcox.test(exec.pay, conf.int=T, conf.level=.8)



## 9.5
data(package='UsingR', rat)

simple.eda(rat)
           

###################
install.packages("stringr")
library(stringr)
list.files()
setwd("C:\\Users\\User\\Downloads\\Compressed\\Lynda.R.Statistics.Essential.Training.Full_p30download.com\\Exercise Files")

mydata <- read.delim("out.txt", fill = TRUE)
head(mydata)
str(mydata)
class(mydata)
library(ggplot2)




data<-readLines("out.txt")
head(data)

a<-grep('Operation A total coverage is*', data, value = TRUE)
b<-grep('Operation B total coverage is*', data, value = TRUE)
c<-grep('Operation ALU Enable total coverage is*', data, value = TRUE)
d<-grep('Operation B2 total coverage is*', data, value = TRUE)




a<-strsplit(data, split = " " )
a
sub("Operation A total coverage is", "", a)
grep("*:",a)
#######################################
a
a<-gsub("[0-9]+:", "", a)
a<-gsub(" Operation A total coverage is ", "", a)
a<-gsub(" ", "", a, fixed = TRUE)
head(a)
x=seq(length(a))
dev.off()
#############################
plot(seq(length(a)),a, xlab = "number of runs",
     main = "Functional coverage",ylab = "%precentage",
     col = "red")

ggplot(data = a, mapping = aes(x=x, y=a))

b<-gsub("[0-9]+:","",b)
b<-gsub(" Operation B total coverage is ", "", b)
b<-gsub(" ", "", b, fixed = TRUE)
head(b)
plot(seq(length(b)),b, col = "blue")
#############################

c<-gsub("[0-9]+:","",c)
c
c<-gsub(" Operation ALU Enable total coverage is ", "", c)
c
c<-gsub(" ", "", c, fixed = TRUE)
head(c)
#############################

d<-gsub("[0-9]+:","",d)
d
d<-gsub(" Operation B2 total coverage is ", "", d)
d<-gsub(" ", "", d, fixed = TRUE)
head(d)

a<-as.data.frame(a)
b<-as.data.frame(b)
c<-as.data.frame(c)
d<-as.data.frame(d)

new<-cbind(x,a,b,c,d)


new

names(new) <- c('x',"opA", "opB", "ALUen", "opB2")
names(new)

str(new)


############################

library(reshape2)
xymelt<- melt(new, id.vars = 'x')
min(xymelt$value)
tail(xymelt$value, n = 100)
#png(filename="faithful.png")
ggplot(data = xymelt, aes(x = x, y = value, color = variable)) +
  geom_line(size=1.5)
  

#dev.off()

#png(filename="faithful2.png")
ggplot(data = xymelt, aes(x = x, y = value, color = variable)) +
  geom_line()+
  facet_wrap(~ variable)

dev.off()




