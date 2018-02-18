svm <- function(selected_genes_df){
    d_train = selected_genes_df[[1]]
    y_train_factor = selected_genes_df[[2]]
    
    d_test = selected_genes_df[[3]]
    y_test_factor = selected_genes_df[[4]]
    
    if (length(y_test_factor) < 0) stop("You do not have test split")
    
    svmRadial_up_sampling<-balanced_sampling_methods_with_ROC(d_train = d_train,
                                                              y_train_factor = y_train_factor,
                                                              model_method = "svmRadial",
                                                              fitControl = fitControl,
                                                              sampling_method = "up",
                                                              preProcess = c("center", "scale"),
                                                              tuneLength = 8)
    
    
    test_pred <- predict(svmRadial_up_sampling, newdata = d_test)
    c <- confusionMatrix(y_test_factor, test_pred)
    return(c)
    
    
}