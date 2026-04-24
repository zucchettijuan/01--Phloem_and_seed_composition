#R version 4.3.1 (2023-06-16 ucrt) -- "Beagle Scouts"
#Copyright (C) 2023 The R Foundation for Statistical Computing
#Platform: x86_64-w64-mingw32/x64 (64-bit)


# =============================================================================
# 1. Load and prepare data
# =============================================================================

#Load libraries
library(tidyverse)
library(pROC)


#Upload data
r5_roc <- read.csv("data/processed/phloem_R5_ROC.csv", check.names = FALSE, sep=";")
r6_roc <- read.csv("data/processed/phloem_R6_ROC.csv", check.names = FALSE, sep=";")


# =============================================================================
# 2. Select predictors and response variables
# =============================================================================

predictors_var <- colnames(r5_roc[-c(1,2)])
response_var <- "HP"


# =============================================================================
# 3. ROC analysis
# =============================================================================

roc_analysis <- function(data,
                         predictors,
                         response){
  result <- data.frame(predictor = character(),
                       AUC = numeric(),
                       ci_inf = numeric(),
                       ci_sup = numeric())
  
  for(pre in predictors){
    roc_obj <- roc(response = data[[response]],
                   predictor = data [[pre]])
    ci_obj = ci.auc(roc_obj)
    
    result_row <- data.frame(predictor = pre,
                             AUC = as.numeric(roc_obj$auc),
                             ci_inf = ci_obj[1],
                             ci_sup = ci_obj[3])
    
    result<- rbind(result, result_row)
  }
  
  result <- arrange(result, desc(AUC))
  best_predictor <- result[1,1]
  roc_obj_best <- roc(response = data[[response]],
                 predictor = data[[best_predictor]])
  plot(roc_obj_best,
       print.auc=T,
       auc.polygon=T,
       main=best_predictor)
  
  return(result)

}


# =============================================================================
# 4. Plot ROC and print predictors
# =============================================================================

roc_analysis(r5_roc,
             predictors_var,
             response_var)

roc_analysis(r6_roc,
             predictors_var,
             response_var)

