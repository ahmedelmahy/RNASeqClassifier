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
# 
# 
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
