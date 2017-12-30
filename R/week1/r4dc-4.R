#
rm(list=ls())
rm(list=(list <- ls())) 
tmp <- read.table(textConnection("1 3 5 1
2 3 2 3
3 3 5 1
4 4 5 1
5 3 2 1
6 4 2 3
7 3 5 1
8 4 5 1
9 3 4 1
10 4 2 1"))

tmp

tmp<-t(tmp[-1])
rownames(tmp)<-c("q1","q2","q3")
tmp
q1<-factor(rep('q1'),10)

r1<-factor(tmp[1,], levels = c(1,2,3,4,5))
table.q1<-table(q1,r1)


q1 <- factor(rep('Q1', 10))
r1 <- factor(tmp[1,], levels=c(1,2,3,4,5))
table.q1 <- table(q1, r1)
table.q1
barplot(table.q1, 
        main="4.1 - Rankings for Q1",
        xlab="Rankings",
        col='darkblue', 
        legend.text=T)
dev.off()

#  table for Q2
q2 <- factor(rep('Q2', 10))
r2 <- factor(tmp[2,], levels=c(1,2,3,4,5))
table.q2 <- table(q2, r2)
png(filename='images/4-1-1b.png')
barplot(table.q2, 
        main="4.1 - Rankings for Q2",
        xlab="Rankings",
        col='red', 
        legend.text=T)
dev.off()

#  2. create a contigency table
q1_2 <- factor(rep(c('Q1', 'Q2'), each=10))
r1_2 <- factor(append(tmp[1,], tmp[2,]), levels=c(1,2,3,4,5))
table(q1_2, r1_2)

#  3. stacked table of Q2 and Q3
png(filename='images/4-1-3.png')
q2_3 <- factor(rep(c('Q2', 'Q3'), each=10))
r2_3 <- factor(append(tmp[2,], tmp[3,]), levels=c(1,2,3,4,5))
table.q2_3 = table(q2_3, r2_3)
barplot(table.q2_3, 
        main="4.1 - Q2 vs Q3",
        xlab="Rankings",
        col=c('red', 'darkgreen'),
        legend=T)
dev.off()



##############

library(MASS)
data(package='MASS')
attach(UScereal)
summary(UScereal)

df <- UScereal

barplot(table(df$shelf,df$mfr),
        main = "4.2 - Manufacturer & Shelf",
        xlab = "Manufacturer",
        ylab = "shelf",
        col = rainbow(3),
        legend.text = T)


boxplot(df$fat ~ df$vitamins,
        main="4.2 - Vitamins & Fat",
        xlab="Vitamins",
        ylab="Fat")

dev.off()

plot(df$sugars, df$sodium,
     main="4.2 - Sugars & Sodium",
     xlab="Sugars",
     ylab="Sodium")
lm <- lm(df$sodium ~ df$sugars)
abline(lm, col="red")
dev.off()
