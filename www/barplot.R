compare_selected_features_barplot <- function(selected_genes_df, with){
    switch (with,
            yes = {
                if (class(selected_genes_df[[1]]) == "numeric"){
                    x <- scale(c(selected_genes_df[[1]],selected_genes_df[[3]]))
                    class <- as.factor(c(as.character(selected_genes_df[[2]]),as.character(selected_genes_df[[4]])))
                    df <- data.frame(x, class = class)
                    colnames(df) <- c(names(selected_genes_df[[1]])[1], "class")
                    df <- df[order(df$class),]
                    df$samplenum <- c(1: dim(df)[1])
                    df <-melt(df,id = c("samplenum","class"))
                    
                    p1 <- ggplot(df, aes(samplenum, value, fill=class)) +
                        geom_col() +
                        facet_grid(variable~.)
                }else{
                x <- scale(rbind(selected_genes_df[[1]],selected_genes_df[[3]]))
                class <- as.factor(c(as.character(selected_genes_df[[2]]),as.character(selected_genes_df[[4]])))
                df <- data.frame(x, class = class)
                df <- df[order(df$class),]
                df$samplenum <- c(1: dim(df)[1])
                df <-melt(df,id = c("samplenum","class"))
                
                p1 <- ggplot(df, aes(samplenum, value, fill=class)) +
                    geom_col() +
                    facet_grid(variable~.)
                
                }},
            no = {
                if (class(selected_genes_df[[1]]) == "numeric"){
                    x <- c(selected_genes_df[[1]],selected_genes_df[[3]])
                    class <- as.factor(c(as.character(selected_genes_df[[2]]),as.character(selected_genes_df[[4]])))
                    df <- data.frame(x, class = class)
                    colnames(df) <- c(names(selected_genes_df[[1]])[1], "class")
                    df <- df[order(df$class),]
                    df$samplenum <- c(1: dim(df)[1])
                    df <-melt(df,id = c("samplenum","class"))
                    
                    p1 <- ggplot(df, aes(samplenum, value, fill=class)) +
                        geom_col() +
                        facet_grid(variable~.)
                }else{
                x <- rbind(selected_genes_df[[1]],selected_genes_df[[3]])
                class <- as.factor(c(as.character(selected_genes_df[[2]]),as.character(selected_genes_df[[4]])))
                df <- as.data.frame(cbind(x, class))
                df <- df[order(df$class),]
                df$samplenum <- c(1: dim(df)[1])
                df <-melt(df,id = c("samplenum","class"))
                
                p1 <- ggplot(df, aes(samplenum, value, fill=class)) +
                    geom_col() +
                    facet_grid(variable~.)
            }}
    )
    print(p1)
}