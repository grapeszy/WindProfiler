########################################################################

library(stats)
library(grid)
library(plyr)
library(ggplot2)


########################################################################
#
# Constants.
#
########################################################################


########################################################################
#
# load data
#
########################################################################
load("../data//o-g-stninfo.RData")

png("../figures/ErrorDisAll.png")
aa<-d$diffsp
x<-rnorm(10000,mean=mean(aa),sd=sd(aa))
hist(d$diffsp,freq=F,breaks=100,xlim=c(-6,6),xlab="wind speed bias [m/s]",main=NULL)#,ylim=c(0,0.2))
lines(density(x, bw=1), col = "red", lwd = 3)
abline(v=mean(aa),lwd=3)

dev.off()

n<-length(aa)
m<-mean(aa)

k<-((num*(num-1)*(num+1))/((num-2)*(num-3)))*(sum((aa-m)^4)/(sum((aa-m)^2)^2))

png("../figures/ErrorDis.png")

par(mfrow = c(2, 2))
aa<-d$diffsp
x<-rnorm(10000,mean=mean(aa),sd=sd(aa))
hist(d$diffsp,freq=F,breaks=100,xlim=c(-6,6),xlab="wind speed bias [m/s]",main=NULL)#,ylim=c(0,0.2))
lines(density(x, bw=1), col = "red", lwd = 3)
abline(v=mean(aa),lwd=3)
mtext("(a)",side=3,at=-6,font=2)


ind <- d$qc==0
aa<-d$diffsp[ind]
x<-rnorm(10000,mean=mean(aa),sd=sd(aa))
hist(d$diffsp[ind],freq=F,breaks=100,xlim=c(-6,6),xlab="wind speed bias [m/s]",main=NULL)#,ylim=c(0,0.2))
lines(density(x, bw=1), col = "red", lwd = 3)
abline(v=mean(aa),lwd=3)
mtext("(b)",side=3,at=-6,font=2)


ind <- d$qc==1
aa<-d$diffsp[ind]
length(aa)
x<-rnorm(10000,mean=mean(aa),sd=sd(aa))
hist(d$diffsp[ind],freq=F,breaks=100,xlim=c(-6,6),xlab="wind speed bias [m/s]",main=NULL)#,ylim=c(0,0.2))
lines(density(x, bw=1), col = "red", lwd = 3)
abline(v=mean(aa),lwd=3)
mtext("(c)",side=3,at=-6,font=2)


ind <- d$qc==2
aa<-d$diffsp[ind]

x<-rnorm(10000,mean=mean(aa),sd=sd(aa))
hist(d$diffsp[ind],freq=F,breaks=100,xlim=c(-6,6),xlab="wind speed bias [m/s]",main=NULL)#,ylim=c(0,0.2))
lines(density(x, bw=1), col = "red", lwd = 3)
abline(v=mean(aa),lwd=3)
mtext("(d)",side=3,at=-6,font=2)


dev.off()



