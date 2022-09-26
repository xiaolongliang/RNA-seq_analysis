#!/bin/R
# count2FPKM
# count2TPM
#### https://blog.csdn.net/weixin_51192038/article/details/124401747

file <- read.table("count_merge.txt",header=TRUE)
file <- as.data.frame(file)
kb <- file$len / 1000
count <- file[3:6]
rpk <- count / kb
fpkm <- t(t(rpk)/colSums(count) * 10^6)
fpkm <- cbind(file[1],fpkm)

tpm <- t(t(rpk)/colSums(rpk) * 1000000)
tpm <- cbind(file[1],tpm)
write.table(as.data.frame(fpkm),file="FPKM.txt",row.names=FALSE,quote=FALSE,sep="\t")
write.table(as.data.frame(tpm),file="TPM.txt",row.names=FALSE,quote=FALSE,sep="\t")
