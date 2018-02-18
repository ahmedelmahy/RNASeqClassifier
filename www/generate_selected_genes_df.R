generate_selected_genes_df <- function(selected_geness,splited_df_list, with){
    switch(with,
           yes = {
               train_x <- splited_df_list[[1]]
               train_x <- train_x[,which(colnames(train_x) %in% selected_geness)]
               if (class(train_x) == "numeric"){
                   names(train_x) <- selected_geness
               }
               train_y <- splited_df_list[[2]]
               
               test_x <- splited_df_list[[3]]
               test_x <- test_x[,which(colnames(test_x) %in% selected_geness)]
               if (class(test_x) == "numeric"){
                   names(test_x) <- selected_geness
               }
               test_y <- splited_df_list[[4]]
           },
           no = {
               train_x <- splited_df_list[[1]]
               train_x <- train_x[,which(colnames(train_x) %in% selected_geness)]
               train_y <- splited_df_list[[2]]
               if (class(train_x) == "numeric"){
                   names(train_x) <- selected_geness
               }
               test_x <- 0
               test_y <- 0
           })
    return(list(train_x,train_y,test_x,test_y))
    
}