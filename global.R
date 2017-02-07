library(shiny)
library(plyr)
library(xlsx)
library(rJava)
library(xlsxjars)
library(ggplot2)
library(googleVis)
library(reshape2)


####creation of example data on local directory for uploading####

# #load a list of common first names
# faveNames<- read.csv("http://dl.dropbox.com/u/25945599/faveNames.csv",stringsAsFactors=FALSE)
# 
# set.seed(4359) # change if want new set
# # create a distribution of results
# # marks improve and reduce in variance over school year
# term1 <- floor(rnorm(25,mean=60,sd=10))
# term2 <- floor(rnorm(25,mean=65,sd=9))
# term3 <- floor(rnorm(25,mean=70,sd=8))
# # sample 25 names and combine with marks
# pupils <- faveNames[sample(nrow(faveNames), size=25, replace=FALSE), ]
# pupils <- arrange(pupils,Gender,Name)
# 
# scores <- cbind(pupils,term1)
# scores <- cbind(scores,term2)
# scores <- cbind(scores,term3)
# 
# # deleberately increase girls marks by 2 and reduce boys by 2
# scores[scores$Gender=="F",]$term1 <- scores[scores$Gender=="F",]$term1+2
# scores[scores$Gender=="F",]$term2 <- scores[scores$Gender=="F",]$term2+2
# scores[scores$Gender=="F",]$term3 <- scores[scores$Gender=="F",]$term3+2
# 
# scores[scores$Gender=="M",]$term1 <- scores[scores$Gender=="M",]$term1-2
# scores[scores$Gender=="M",]$term2 <- scores[scores$Gender=="M",]$term2-2
# scores[scores$Gender=="M",]$term3 <- scores[scores$Gender=="M",]$term3-2
# 
# 
# 
# write.csv(scores,"yourfilelocation/scores.csv", row.names=FALSE)
# 
