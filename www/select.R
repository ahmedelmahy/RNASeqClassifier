selectv <- function(model_list,train_x, train_y, num_genes){
    selected_genes <- list()
    model = model_list[[1]]
    for (model in model_list){
        if (model$modelInfo$label == "RF_up_sampling"){
            RF_up_sampling_selected_genes <- lapply(1:2, FUN=function(i) {
                model <-
                    balanced_sampling_methods_with_ROC(d_train = train_x,
                                                       y_train_factor = train_y,
                                                       model_method = "rf",
                                                       fitControl = fitControl,
                                                       sampling_method = "up",
                                                       tuneGrid =
                                                           data.frame(mtry=model$bestTune$mtry),
                                                       verboseIter = TRUE)
                var.imp.rf <- varImp(model) # random forest
                var.imp.rf <- data.frame(cbind(row.names(var.imp.rf$importance),
                                               var.imp.rf$importance[, 1]))
                names(var.imp.rf) <- c("genes", "imp")
                var.imp.rf <- var.imp.rf[order(as.numeric(as.matrix(var.imp.rf$imp)),
                                               decreasing = T), ]
                return(var.imp.rf[1:num_genes, ])
            })
            selected_genes[[length(selected_genes)+1]] <- names(sort(table(unlist(lapply(
                RF_up_sampling_selected_genes,FUN=function(x)x$genes))), decreasing=T)[1:num_genes])
            
        }
        #-----------------------------------------------------------------------
        if (model$modelInfo$label == "RF_smote_sampling"){
            RF_smote_sampling_selected_genes <- lapply(1:2, FUN=function(i) {
                model <-
                    balanced_sampling_methods_with_ROC(d_train = train_x,
                                                       y_train_factor = train_y,
                                                       model_method = "rf",
                                                       fitControl = fitControl,
                                                       sampling_method = "smote",
                                                       tuneGrid =
                                                           data.frame(mtry=model$bestTune$mtry),
                                                       verboseIter = TRUE)
                var.imp.rf <- varImp(model) # random forest
                var.imp.rf <- data.frame(cbind(row.names(var.imp.rf$importance),
                                               var.imp.rf$importance[, 1]))
                names(var.imp.rf) <- c("genes", "imp")
                var.imp.rf <- var.imp.rf[order(as.numeric(as.matrix(var.imp.rf$imp)),
                                               decreasing = T), ]
                return(var.imp.rf[1:num_genes, ])
            })
            selected_genes[[length(selected_genes)+1]] <- names(sort(table(unlist(lapply(
                RF_smote_sampling_selected_genes,FUN=function(x)x$genes))), decreasing=T)[1:num_genes])
            
        }
        #-----------------------------------------------------------------------
        if (model$modelInfo$label == "glm_up_sampling"){
        glm_up_sampling_selected_genes <- lapply(1:2, FUN=function(i) {
            model <- balanced_sampling_methods_with_ROC(d_train = train_x,
                                                                  y_train_factor = train_y,
                                                                  model_method = "glmnet",
                                                                  fitControl = fitControl,
                                                                  sampling_method = "up",
                                                                  family = "binomial",
                                                                  tuneGrid = data.frame(
                                                                      alpha = model$bestTune$alpha,
                                                                      lambda = model$bestTune$lambda))
            var.imp.glm <- varImp(model) # glmnet
            
            var.imp.glm <- data.frame(genes = row.names(var.imp.glm$importance),
                                      imp = var.imp.glm$importance[, 1])
            var.imp.glm <- var.imp.glm[order(var.imp.glm$imp, decreasing = T), ]
            
            return(na.omit(var.imp.glm[1:num_genes, ]))
        })
        selected_genes[[length(selected_genes)+1]] <- names(sort(table(unlist(lapply(
            glm_up_sampling_selected_genes,FUN=function(x)x$genes))), decreasing=T)[1:num_genes])
    }
    #---------------------------------------------------------------------------
        if (model$modelInfo$label == "glm_smote_sampling"){
            glm_up_sampling_selected_genes <- lapply(1:2, FUN=function(i) {
                model <- balanced_sampling_methods_with_ROC(d_train = train_x,
                                                            y_train_factor = train_y,
                                                            model_method = "glmnet",
                                                            fitControl = fitControl,
                                                            sampling_method = "smote",
                                                            family = "binomial",
                                                            tuneGrid = data.frame(
                                                                alpha = model$bestTune$alpha,
                                                                lambda = model$bestTune$lambda))
                var.imp.glm <- varImp(model) # glmnet
                
                var.imp.glm <- data.frame(genes = row.names(var.imp.glm$importance),
                                          imp = var.imp.glm$importance[, 1])
                var.imp.glm <- var.imp.glm[order(var.imp.glm$imp, decreasing = T), ]
                
                return(na.omit(var.imp.glm[1:num_genes, ]))
            })
            selected_genes[[length(selected_genes)+1]] <- names(sort(table(unlist(lapply(
                glm_up_sampling_selected_genes,FUN=function(x)x$genes))), decreasing=T)[1:num_genes])
        }
    }
    selected_genes_final <- names(sort(table(unlist(selected_genes)))[1:num_genes])
}