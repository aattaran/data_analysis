install.packages("swirl")
packageVersion("swirl")
library(swirl)
install_from_swirl("Statistical Inference")
swirl()

add2<- function(x,y){
   x+y
}

add2(4,9)

above10<-function(x){
  
  return(x[x>10])
  
}
above10(c(1:32))

above<-function(x,n){
  
  return(x[x>n] )
}

above((1:43),20)


meancol<-function(x, removeNA=TRUE){
  
  nc<- ncol(x);
  nr<- nrow(x);
  means<-numeric(nc)
  for (i in 1:nc){
    means[i]<- mean(x[,i],na.rm = removeNA)
  }
  return (means)
}

meancol(matrix(1:10,2,5))

meancol(airquality, TRUE)

matrix(1:10,2,5)

make<-function(n){
  pow<-function(x)   {x^n}
  pow
}

cube<-make.pow(3)
cube(4)

square<-make.pow(2)
square(3)



y<-10

f<-function(x){
  y<-2
  y^2+g(x)
  
}

g<-function(x){x*y}

f(3)


x <- c(1,3, 5)
y <- c(3, 2, 10)

cbind(x, y)


x <- list(2, "a", "b", TRUE)
x[[2]] 
x[2]

x <- c(17, 14, 4, 5, 13, 12, 10)
x[x>10]<-1
x
