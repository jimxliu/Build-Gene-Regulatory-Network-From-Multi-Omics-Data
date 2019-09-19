
 library(GeneNetworkBuilder)
 library(Rgraphviz)


### Plotting Function###

 plotNetwork<-function(gR, layouttype="dot", ...)
{
 if(!is(gR,"graphNEL")) stop("gR must be a graphNEL object")
 if(!(GeneNetworkBuilder:::inList(layouttype, c("dot", "neato", "twopi", "circo", "fdp")))){
 stop("layouttype must be dot, neato, twopi, circo or fdp")
 }

 g1<-Rgraphviz::layoutGraph(gR, layoutType=layouttype, ...)
 nodeRenderInfo(g1)$col <- nodeRenderInfo(gR)$col
 nodeRenderInfo(g1)$fill <- nodeRenderInfo(gR)$fill
 renderGraph(g1)
 }



##load C. elegans miRNA ID lists
 data("ce.miRNA.map")
##view data
 table(ce.miRNA.map)
#colnames(table(ce.miRNA.map))
#rownames(table(ce.miRNA.map))

##load GNB-embedded regulatory network of C. elegans.
 data("ce.interactionmap")
##load data required
 data("example.data")
##build the network by binding list and interaction map
sifNetwork<-buildNetwork(TFbindingTable=example.data$ce.bind, interactionmap=ce.interactionmap, level=2)

##filter the network by expression data
cifNetwork<-filterNetwork(rootgene="WBGene00000912", sifNetwork=sifNetwork, exprsData=uniqueExprsData(example.data$ce.exprData), mergeBy="symbols",miRNAlist=as.character(ce.miRNA.map[ , 1]),remove_miRNA=FALSE, tolerance=1)

##generate graphNEL object for the network
gR<-polishNetwork(cifNetwork=cifNetwork, nodecolor=colorRampPalette(c("green", "yellow", "red"))(5))

plotNetwork(gR)





