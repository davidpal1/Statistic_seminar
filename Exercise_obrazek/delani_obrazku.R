
jadra <- c(1,2,4,8,16,32)
casy <- c(3.343,8.574,15.792,18.958,35.765, 67.835)
plot(y=casy,x=jadra,pch=15,col="red",cex=2,main="Čas programu při daném počtu jader")
lines(jadra,casy,col="red")
