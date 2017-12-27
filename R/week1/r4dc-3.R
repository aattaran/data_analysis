#3.1
rm(list=ls())
data("florida")

names(florida)

head(florida)

?florida

attach(florida)
result.lm<-lm(BUCHANAN~BUSH)
plot(BUSH,BUCHANAN)
abline(rlm(BUCHANAN ~ BUSH),lty='1')
abline(rlm(BUCHANAN[-50] ~ BUSH[-50]),lty='2')
seq(0,4,by=.1)

plot(x,x^2,type="l")
