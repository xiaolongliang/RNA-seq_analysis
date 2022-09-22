#!/bin/R
# count2FPKM
file <- read.table("count_merge.txt",header=TRUE)
file <- as.data.frame(file)
rpkm <- data.frame(sapply(file[4:11],function(column) 10^9 * column / file$Length / sum(column)))
ID <- file[1]
gene <- file[2]
rpkm <- cbind(ID,gene,rpkm)
write.table(rpkm,file="RPKM.txt",row.names=FALSE,quote=FALSE,sep="\t")
