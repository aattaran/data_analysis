#
x<-sample(1:6,100,replace=TRUE)
hist(x)

x<-sample(c(TRUE,FALSE), 100, replace = TRUE)
x<-as.numeric(x)
hist(x)

x<-sample(c("TRUE","FALSE"), 100, replace = TRUE)
barplot(x)


cards = paste(rep(c("A",2:10,"J","Q","K"),4),c("H","D","S","C"))
cards


####################

set.seed(6.1)
round(runif(10, min = 0,max = 10))


set.seed(6.2)
x<-rnorm(10, mean = 5, sd = 5)
hist(x)

sum(x[x<0])
sum(x<0)


set.seed(6.3)
x<-rnorm(100,mean = 100, sd = 10)
sd(x)
sum(x>mean(x)&x<mean(x)+sd(x))
sum(x>mean(x)&x<mean(x)+sd(x))
x[x>mean(x)&x<mean(x)+sd(x)]


m = 100
s = 10
x <- rnorm(100, mean=m, sd=s)

sum(x<m-2*s | x>m+2*s)

x<-sample(c('h',"t"), 50, replace = TRUE)
sum(x=="h")

set.seed(6.4)
n=1
p=0.5
x<-rbinom(50, n,p)
sum(x==1)

set.seed(6.5)
x<- sample(1:6, 100, replace = TRUE)
x
sum(x==6)

set.seed(6.6)
x<-sample(1:49, 6, replace = FALSE)
x

set.seed(6.7)
x<-qnorm(0.05,0,1)

x


set.seed(6.10)
x <- rexp(100, 1/10)
x
hist(x, probability = T, 
     col=gray(0.9),
     main="6.10 - exponential, mean=10")
curve(dexp(x, 1/4), col="red", add=T)
dev.copy(png, "images/6-10.png")


x<-rnorm(5,mean=0,sd=1:5)
hist(x)


for(i in 1:5) print(primes[i])
