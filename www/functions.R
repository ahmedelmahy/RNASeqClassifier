library(DESeq2)
normalise <- function(data, method){
    if (method == "deseq"){
        cat("hi")
        print("hfs")
        class <- factor(dat$class)
        dds <- DESeqDataSetFromMatrix(countData = djata,design= ~ class)
        dds <- DESeq(dds, parallel=TRUE , BPPARAM=MulticoreParam(20))
        res <- results(dds)
        res_sel <- res [which(res$padj< config_dfpadj_max & 
                                  abs(res$log2FoldChange)>=config_df$lfc_min),]
        
        dat <- read.csv("df_lym_ecz.csv",header = TRUE ,
                        row.names = 1)
        cat("hhhh")
        class <- factor(data$class)
        data$class <- NULL
        
        dat = t(data)
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
        
    } else if(method == "voom"){
        
    }
    
    
}