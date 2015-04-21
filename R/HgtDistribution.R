########################################################################

library(stats)
library(grid)
library(plyr)
library(ggplot2)
library(lattice)

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
load("./o-g-stninfo.RData")

d <- datao
ind <- d$obstype == "LC"

########################################################################
# plot the hist
png(file="F:/R_work/wpr_error/figures/fig2.png")
par(mfcol=c(2,1))

br <- seq(0,(length(d$shgt[ind])/100)*15,by=(length(d$shgt[ind])/100)*3)
xr <- seq(0,15,by=1)
yr <- seq(0,11000,by=2750)
hist(d$shgt[ind]/1000,breaks=30,xlim=c(0,15),ylim=c(0,11346),xlab="Obs Height [km]",
     ylab="Density",main=NULL,axes=F)
axis(1,at=xr,labels=xr)
axis(4,at=yr,labels=yr)
axis(2,at=br,labels=c('0%','3%','6%','9%','12%','15%'))
text(15,6000,'Frequency',srt=90)
text(0,11346,'(a)')


br <- seq(0,(length(d$shgt[!ind])/100)*15,by=(length(d$shgt[!ind])/100)*3)
xr <- seq(0,15,by=1)
yr <- seq(0,2200,by=550)
hist(d$shgt[!ind]/1000,breaks=30,xlim=c(0,15),xlab="Obs Height [km]",ylab="Density",
     ylim=c(0,2295),main=NULL,freq=T,axes=F)
axis(1,at=xr,labels=xr)
axis(4,at=yr,labels=yr)
axis(2,at=br,labels=c('0%','3%','6%','9%','12%','15%'))
text(15,1100,'Frequency',srt=90)
text(0,2295,'(b)')
dev.off()
