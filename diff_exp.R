## different expression analysis

if (!requireNamespace("DESeq2",quietly = TRUE))
       	BiocManager::install("DESeq2")
library(DESeq2)
library(tidyverse)

####### 可变参数##########

setwd("./")
file <- read.table("count_merge.txt",header = TRUE,row.names = 1)
count <- file[1:4]
count <- as.matrix(count)

sample <- as.data.frame(colnames(count))
sample$deal <- c(rep("H",4),rep("L",4))
names(sample) <- c("sam","condition")
rownames(sample) <- sample$sam
sample %>% select(-1) -> sample


dds <- DESeqDataSetFromMatrix(countData = count,colData = sample,design = ~ condition)
dds <- DESeq(dds)
res <- results(dds,contrast = c("condition","H","L"))
resOrdered <- res[order(res$padj),]
sum(res$padj < 0.05,na.rm = TRUE)

#火山图
#plotMA(res)
plotMA(res,alpha=0.05,colSig="red",colLine="skyblue")

#上调，下调基因
filter_up <- subset(res,pvalue< 0.05 & log2FoldChange > 1)
filter_down <- subset(res,pvalue< 0.05 & log2FoldChange < -1)

#save
write.table(as.data.frame(resOrdered),file = "differental_gene.txt",quote = FALSE,sep = ",")
write.table(filter_up,file = "gene_up.txt",quote = FALSE)
write.table(filter_down,file = "gene_down.txt",quote = FALSE)
