normaliv <- function (du, with){
    switch(with, deseq2 = {
        class <- factor(du$class)
        df2 <- du[,-which(colnames(du) == "class")]
        dat = t(df2)
        dds <- DESeqDataSetFromMatrix(countData = dat,
                                      colData = DataFrame(class),
                                      design= ~ class)
        dds <- DESeq(dds)
        res <- results(dds)
        res_sel <- res [which(res$padj< config_df$padj_max & 
                                  abs(res$log2FoldChange)>=config_df$lfc_min),]
        genes <- res_sel@rownames
        d <- dds[genes,]
        d <- as.data.frame(t(counts(d ,
                                    normalized = TRUE)))
        d$class <- class
        return(d)
    })
}
