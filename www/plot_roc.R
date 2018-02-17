plot_multipe_rocs <- function(model_title_list){
    results_list_roc <- list(NA)
    for(i in 1:length(model_list)){
        myRoc_on_train_data <- roc(predictor = model_title_list[[i]]$pred$lym,
                                   response = model_title_list[[i]]$pred$obs)
        message(auc(myRoc_on_train_data))
        results_list_roc[[i]] <- data_frame(
            True_positive_rate = myRoc_on_train_data$sensitivities,
            False_positive_rate = 1 - myRoc_on_train_data$specificities,
            modell = model_list[[i]]$modelInfo$label)
    }
    results_df_roc <- bind_rows(results_list_roc)

    ggplot(aes(x = False_positive_rate,  y = True_positive_rate, group = modell), data = results_df_roc) +
        geom_line(aes(color = modell), size = 1) +
        geom_abline(intercept = 0, slope = 1, color = "gray", size = 1) +
        theme_bw(base_size = 18)
}