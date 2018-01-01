#

data(package="UsingR", emissions)
summary(emissions)
attach(emissions)
boxplot(emissions$GDP~emissions$CO2)
dev.off()
plot(GDP,CO2)
lm<-lm(CO2~GDP)
abline(lm,col = "red") 

dev.off()

plot(GDP[-1],CO2[-1])
detach(emissions)
#############################

data(package = "UsingR", chips)
summary(chips)
attach(chips)
png(filename = "image/5-2-2.png")
boxplot(chips, main = "5.2 chips")

dev.off()

library(UsingR)
library(lattice) 
simple.densityplot(chips)

dev.off()

boxplot(chips)
simple.densityplot(chips)


##############

library(MASS)

data(package="UsingR", kid.weights)
summary(kid.weights)

attach(kid.weights)

age.yr = cut(age, seq(0,144,by=12), labels=0:11)
age.yr

boxplot(weight~age.yr, main = "5.4 kids ")
detach(kid.weights)
################################



data(package='UsingR', carbon)
summary(carbon)
attach(carbon)

boxplot(Monoxide~Site)
dev.off()
detach(carbon)

######################

data(package='UsingR', babies)
summary(babies)

attach(babies)

boxplot(parity, age)
abline(lm(age~parity), col = "red")
dev.off()

boxplot( age, dage)
abline(lm(dage~age), col = "red")



plot(wt ~ gestation, 
     main="5.6 - babies: gestation vs weight")
rect(par("usr")[1],par("usr")[3],par("usr")[2],par("usr")[4],col = "gray")
tmp = levels(factor(smoke))
points(wt ~ gestation, 
       pch=smoke, 
       col=heat.colors(n=length(tmp)))
legend(locator(1), 
       title="Factor: smoke",
       cex=0.8,
       legend=tmp, 
       pch=smoke, 
       col=heat.colors(n=length(tmp)),
       horiz=T)
dev.copy(png, "images/5-6-2c.png")
dev.off()