read_df <- readv(file.choose(), 1)
normalized_df <<- normaliv(read_df, "deseq2")
normalized_df2 <- normalized_df
save(normalized_df2, file = "normalized_df2.rda")

