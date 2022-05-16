
jadra <- c(1,2,4,8,16,32)
casy <- c(3.343,8.574,15.792,18.958,35.765, 67.835)
casyr <- c(7.322,8.188,4.305,4.198, 4.470,6.387)
plot(y=casyr,x=jadra,pch=15,col="red",cex=2,main="Čas programu při daném počtu jader")
lines(jadra,casyr,col="red")
