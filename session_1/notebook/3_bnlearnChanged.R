#install.packages("bnlearn")
library(bnlearn)
library(igraph)

######## make a simple DAG
dag = model2network("[A][S][E|A:S][O|E][R|E][T|O:R]")

arc.set = matrix(c("A", "E",
                   "S", "E",
                   "E", "O",
                   "E", "R",
                   "O", "T",
                   "R", "T"),
                 byrow = TRUE, ncol = 2,
                 dimnames = list(NULL, c("from", "to")))
dag = empty.graph(c("A", "S", "E", "O", "R", "T"))
arcs(dag) = arc.set
graphviz.plot(dag,shape = "ellipse")
dag$nodes

#plot(dag,shape = "ellipse")


##########################################################
### #write.csv(exprMat_filtered_log,"/Users/zhuy16/GRN/Gene_Regulatory_Networks/data/exprMat_filtered_log.csv")
# 

getwd()
exprMatRaw=read.csv("../data/3_BNLEARN/exprMat_filtered.csv",row.names = 1,header = T)
exprMatRaw=log(exprMat1+1)
nrow(exprMatRaw)
ncol(exprMatRaw)
exprMat1=exprMatRaw[rowMeans(exprMatRaw)>1.2,]
nrow(exprMat1)
ncol(exprMat1)
exprMat1[1:5,1:5]
#BiocManager::install("Rgraphviz")
library(Rgraphviz)
str(exprMat1)
dag = hc(data.frame(t(exprMat1)))
#dag = hc(data.frame(t(exprMat_filtered_log)))
plot(dag)
str(dag)

graphviz.plot(dag,layout="twopi",shape = "ellipse")
graphviz.plot(dag,layout="neato",shape = "ellipse")
graphviz.plot(dag,layout="dot",shape = "ellipse")
length(dag$arcs)

getwd()
write.csv(dag$arcs,"../data/3_BNLEARN/arcsInTheBayesNet.csv")

dag$nodes[1:5]
?graphviz.plot()

dagn=dag$nodes
class(dagn)
length(dagn)
dagn[[1]]$parents
dagn[[1]]$children

