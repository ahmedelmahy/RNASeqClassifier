# 
# 
# directory <- "/home/ahmed/Downloads/tgca/92fc3520-e19d-4499-be04-93e1d8fe1d32"
# sampleFiles <- c(list.files(directory)[1],list.files(directory)[1])
# sampleCondition <- rep(c("tumor","tumoragain"), 1)
# sampleTable <- data.frame(sampleName = sampleFiles,
#                           fileName = sampleFiles,
#                           condition = sampleCondition)
# library("DESeq2")
# ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable,
#                                        directory = directory,
#                                        design= ~ condition)
# 
# c <- counts(ddsHTSeq)
# 
# library(TCGAbiolinks)
# query.met.gbm <- GDCquery(project = "TCGA-BRCA",
#                           data.category = "Transcriptome Profiling",
#                           experimental.strategy = "RNA-Seq",
#                           workflow.type = "HTSeq - Counts")
# GDCdownload(query.met.gbm)
# 
# 
# met.gbm.450 <- GDCprepare(query = query.met.gbm,
#                           save = TRUE, 
#                           save.filename = "gbmDNAmet450k.rda",
#                           summarizedExperiment = TRUE)
# 
# 
# 
# 
# 
# 
# directory <- "/home/ahmed/Documents/pj/RNASeqClassifier/GDCdata/pdfss"
# sampleFiles <- list.files(directory)
# sampleTable <- data.frame(sampleName = sampleFiles,
#                           fileName = sampleFiles,
#                           condition = sampleCondition)
# 
# 
# 
# 
# 
# 
# 
# 
# mkdir fff
# find . -name "*.gz" -type f -exec cp {} ./pdfss \;
# 
