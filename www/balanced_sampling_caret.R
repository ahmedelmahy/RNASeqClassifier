balanced_sampling_methods_with_ROC <- function(d_train,
                                               y_train_factor,
                                               model_method,
                                               fitControl,
                                               sampling_method, ...){
    switch(sampling_method,
           original = {
               message("doing the original model")
               fit <- caret::train(x = d_train, y = y_train_factor,
                                   method=model_method,
                                   trControl =fitControl,
                                   metric = "ROC",...)
               
               #message("#fitControl now uses the same seed to ensure same cross-validation splits")
               #fitControl$seeds <<- fit$control$seeds
           } ,
           weights = {
               message("#using weights for sampling")
               model_weights <- ifelse(y_train_factor ==
                                           names(table(y_train_factor)[1]),
                                       (1/table(y_train_factor)[1]) * 0.5,
                                       (1/table(y_train_factor)[2]) * 0.5)
               
               fit <- caret::train(x = d_train, y = y_train_factor,
                                   method=model_method,
                                   weights = model_weights,
                                   trControl =fitControl,
                                   metric = "ROC", ...)
           },
           up = {
               message("# using up sampling")
               fitControl$sampling <- "up"
               fit <- train(x = d_train,
                            y = y_train_factor,
                            method =model_method,
                            metric = "ROC",
                            trControl = fitControl,...)
               
           },
           down = {
               message("# using down sampling")
               fitControl$sampling <- "down"
               fit <- train(x = d_train,
                            y = y_train_factor,
                            method = model_method,
                            metric = "ROC",
                            trControl = fitControl,...)
           },
           smote = {
               message("# using smote sampling")
               fitControl$sampling <- "smote"
               fit <- train(x = d_train,
                            y = y_train_factor,
                            method = model_method,
                            metric = "ROC",
                            trControl = fitControl,...)
           })
    return(fit)
}
