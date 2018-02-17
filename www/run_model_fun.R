runv <- function(splited_df_list, with){
    d_train = splited_df_list[[1]]
    y_train_factor = splited_df_list[[2]]
    switch (with,
            RF_up_sampling = {
                RF_up_sampling <- balanced_sampling_methods_with_ROC(d_train = d_train,
                                                                     y_train_factor = y_train_factor,
                                                                     model_method = "rf",
                                                                     fitControl = fitControl,
                                                                     sampling_method = "up",verboseIter = TRUE)
                
                RF_up_sampling$modelInfo$label <- "RF_up_sampling"
                return(RF_up_sampling)
            },
            RF_smote_sampling = {
                RF_smote_sampling <- balanced_sampling_methods_with_ROC(d_train = d_train,
                                                                        y_train_factor = y_train_factor,
                                                                        model_method = "rf",
                                                                        fitControl = fitControl,
                                                                        sampling_method = "smote",verboseIter = TRUE)
                
                RF_smote_sampling$modelInfo$label <- "RF_smote_sampling"
                return(RF_smote_sampling)
            },
            glm_up_sampling = {
                glm_up_sampling <- balanced_sampling_methods_with_ROC(d_train = d_train,
                                                                      y_train_factor = y_train_factor,
                                                                      model_method = "glmnet",
                                                                      fitControl = fitControl,
                                                                      sampling_method = "up",
                                                                      family = "binomial")
                glm_up_sampling$modelInfo$label <- "glm_up_sampling"
                return(glm_up_sampling)
            },
            glm_smote_sampling = {
                glm_smote_sampling <- balanced_sampling_methods_with_ROC(d_train = d_train,
                                                                         y_train_factor = y_train_factor,
                                                                         model_method = "glmnet",
                                                                         fitControl = fitControl,
                                                                         sampling_method = "smote",
                                                                         family = "binomial")
                glm_smote_sampling$modelInfo$label <- "glm_smote_sampling"
                return(glm_smote_sampling)
                }
            
    )
}