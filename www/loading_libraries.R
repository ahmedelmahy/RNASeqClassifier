library(dplyr) # for data manipulation
library(caret) # for model-building
library(DMwR) # for smote implementation
library(purrr) # for functional programming (map)
library(pROC) # for AUC calculations
library(magrittr)
library("BiocParallel")
library(DESeq2)
library("caTools") # for sample.split()

library(shiny)


source("www/config_df.R")
source("www/texts.R")
source("www/read_fun.R")
source("www/normalise_fun.R")
source("www/split_fun.R")
source("www/run_model_fun.R")
source("www/plot_roc.R")
source("www/balanced_sampling_caret.R")


library(doMC)
registerDoMC(cores = config_df$cores)


fitControl <- trainControl(method = config_df$resampling_method,
                           classProbs = T,
                           savePredictions = T,
                           summaryFunction = twoClassSummary,
                           verboseIter = TRUE, allowParallel = TRUE)
