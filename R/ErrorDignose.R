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

ind<-(d$diffsp<=2.5)&(d$diffsp>=-2.5)
numsp  <-length(d$diffsp[ind])

ind<-(d$shgt<=1000)&(d$shgt>=0)
num1000  <-length(d$diffsp[ind])

ind<-(d$shgt<=3000)&(d$shgt>=0)
num3000  <-length(d$diffsp[ind])

ind<-(d$shgt>=6000)
num6000  <-length(d$diffsp[ind])


numall   <-length(d[,1])
