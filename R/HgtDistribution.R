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
png("../figures/fig3.png")
#d<-d[sample(nrow(d),1000),]

grid.newpage()
pushViewport(viewport(layout=grid.layout(1,2)))
vplayout <- function(x,y)
  viewport(layout.pos.row=x,layout.pos.col=y)


br<-c(seq(0,6000,by=1000))
hgtbreak<-c(seq(0,15,by=1))
num<-paste("Sample Number: ",length(d$shgt),sep="")

p<-ggplot(d,aes(shgt))
figh<-p+geom_histogram(colour = "darkgreen",binwidth=250)+
  coord_cartesian(,ylim=c(0,7000))+
  scale_y_continuous("Frequency",breaks=c(seq(0,7000,by=1000)))+
  scale_x_continuous("Observation Height [km]",limits=c(0,15000),breaks=hgtbreak*1000,labels=hgtbreak)+
  geom_text(data = NULL, x = 1, y =6500, label = "(a)",font=2,size=6) +
  geom_text(data = NULL, x = 7000, y =6000, label = num,font=2,size=6) +
  theme(axis.title.x = element_text(size=16,colour = "black",face = "bold"),
      axis.title.y = element_text(size=16,colour = "black",face = "bold"),
      axis.text.x = element_text(size=16),
      axis.text.y = element_text(size=16))




d1<-d[sample(nrow(d),1000),]

psp<-ggplot(d,aes(diffsp,shgt/1000))

figsp<-psp+stat_density2d(aes(fill = ..level..), geom="polygon") +
#figsp<-psp+stat_density2d() +
  coord_cartesian(xlim=c(-5,5),ylim=c(0,7))+
  scale_fill_continuous("level",high='red2',low='blue4')+#,limits=c(0,0.05),breaks=c(0.01,0.02,0.03,0.04),labels=c("1%","2%","3%","4%"))+
  scale_x_continuous("Wind Speed Bias [m/s]")+
  scale_y_continuous("Obs Height [km]") +
  geom_text(data = NULL, x = -4, y =6.5, label = "(b)",font=2,size=6) +
  theme(axis.title.x = element_text(size=16,colour = "black",face = "bold"),
        axis.title.y = element_text(size=16,colour = "black",face = "bold"),
        axis.text.x = element_text(size=16),
        axis.text.y = element_text(size=16))


print(figsp,vp=vplayout(1,2))
print(figh,vp=vplayout(1,1))

dev.off()
