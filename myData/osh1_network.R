setwd("~/Documents/courses/bioinformatics/final_project/")
library("GeneNetworkBuilder")
# load and clean data
bind <- read.csv("bind_list.csv")
expr <- read.csv("exprdata.csv")
interact <- read.csv("interaction.map")
mir <- read.csv("miRNA.map",header = FALSE)

# build network using bind list and interaction map
sifNetwork<-buildNetwork(TFbindingTable=bind, interactionmap=interact, level=2)

# filter network by gene expression and miRNA list
cifNetwork<-filterNetwork(rootgene="LOC_Os03g51690", sifNetwork=sifNetwork, exprsData=uniqueExprsData(expr),mergeBy = "symbols", miRNAlist=as.character(mir[ , 1]),tolerance = 1)

