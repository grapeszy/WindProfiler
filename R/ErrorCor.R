########################################################################
##
##  Name: VerCorr.R 
##
##  Description:
##    Calculate the vertical error corr of the wind profiler data
##
##  Usage:
##
##  Arguments:
##    "-save"     calls save.image() before exiting R.
##
##  Details:
##
##  Examples:
##    Rscript plot_rhist.R \
##      METv3.0/out/point_stat/*_rhist.txt
##
##   Author:
##		original: plot_mpr.R    John Halley Gotway (johnhg@ucar.edu), NCAR-RAL/DTC
##      		02/09/2011
##		Yu Zhang (kaoyanzai@163.com), CAMS/IUM
##		Yuhuan Li (), IUM
##		16/07/2014
##
##
########################################################################

library(stats)

########################################################################
#
# Constants.
#
########################################################################



########################################################################
#
# Handle the arguments.
#
########################################################################
########################################################################
#
# Read the input files.
#
########################################################################
tmpdir<-c("../data/")
out<-c()
file_list<-list.files(path=tmpdir,pattern="cor")

i<-1
cor<-c()
print(paste("Reading:", file_list[i]))
tmp_file <- paste(tmpdir,file_list[i],sep="")
tmpdata  <- read.table(tmp_file, header=TRUE)
cor<-tmpdata


#get the obs height
for(j in 1:max(cor$i)){
  ind <- cor$i==j
  cor$shgt[ind] <- cor$hgt[j]
}


for(i in 2:length(file_list)) {
  tmpdata<-c()
  print(paste("Reading:", file_list[i]))
  tmp_file <- paste(tmpdir,file_list[i],sep="")
  tmpdata  <- read.table(tmp_file, header=TRUE)
  
  
  for(j in 1:max(tmpdata$i)){
    ind <- tmpdata$i==j
    tmpdata$shgt[ind] <- tmpdata$hgt[j]
  }
  
  cor<-rbind(cor,tmpdata)
}


# re-bin in 60

cor$hgts <- as.integer(cor$hgt/50+1)*50

#pdf(paste("../figures/ErrorCor",".pdf",sep=""), height=8.5, width=11, useDingbats=FALSE)
png("../figures/ErrorCor.png")
#par(mfrow=c(1,2),mar=c(5, 4, 4, 2) ,oma=c(0.1,0.1,0.4,0.1))#,mai=c(0.1,0.1,0.4,0.1))
ind<-(cor$hgts>=0)&(cor$hgts<=1000)
y<-abs(cor$rsp[ind])
x<-cor$hgts[ind]
outbox<-data.frame(x,y)
title="Vertical cor for wind speed"
boxplot(y~x,data=outbox,outline=FALSE,ylim=c(0,1),#xlim=c(0,1400),
        main=NULL,
        xlab="Height difference [m]",ylab="Correlation Coefficient",range=0.5)
axis(2,at=c(0.7,0.9),labels=c(0.7,0.9))
abline(h=0.9,lty=2)
abline(h=0.7,lty=2)
dev.off()

#for the low/high(1000m) level

png("../figures/ErrorCorLev.png")
#pdf(paste("allstn_lowlev",".pdf",sep=""), height=8.5, width=11, useDingbats=FALSE)
par(mfrow=c(1,2),mar=c(5, 4, 4, 2) ,oma=c(0.1,0.1,0.4,0.1))#,mai=c(0.1,0.1,0.4,0.1))

ind<-(cor$hgts<=1000)&(cor$shgt<=1000)
y<-abs(cor$rsp[ind])
x<-cor$hgts[ind]
outbox<-data.frame(x,y)
boxplot(y~x,data=outbox,outline=FALSE,ylim=c(0,1),#xlim=c(0,1400),
        main=NULL,
        xlab="Height difference [m]",ylab="Correlation Coefficient",range=0.5)
axis(2,at=c(0.7,0.9),labels=c(0.7,0.9))
abline(h=0.9,lty=2)
abline(h=0.7,lty=2)
mtext("(a)",side=3,at=0,font=2)


ind<-(cor$hgts<=1000)&(cor$shgt>=1000)
y<-abs(cor$rsp[ind])
x<-cor$hgts[ind]
outbox<-data.frame(x,y)
title="Vertical cor for wind speed"
boxplot(y~x,data=outbox,outline=FALSE,ylim=c(0,1),#xlim=c(0,1400),
        main=NULL,
        xlab="Height difference [m]",ylab="Correlation Coefficient",range=0.5)
axis(2,at=c(0.7,0.9),labels=c(0.7,0.9))
abline(h=0.9,lty=2)
abline(h=0.7,lty=2)
mtext("(b)",side=3,at=0,font=2)

dev.off()





