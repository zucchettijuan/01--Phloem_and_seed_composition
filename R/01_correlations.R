#R version 4.3.1 (2023-06-16 ucrt) -- "Beagle Scouts"
#Copyright (C) 2023 The R Foundation for Statistical Computing
#Platform: x86_64-w64-mingw32/x64 (64-bit)


# =============================================================================
# 1. Load and prepare data
# =============================================================================

#Load libraries
library(tidyverse)
library(pheatmap)
library(RColorBrewer)

#Upload data
phloem_R5 <- read.csv("data/processed/phloem_R5.csv", check.names = FALSE, sep=";")
phloem_R6 <- read.csv("data/processed/phloem_R6.csv", check.names = FALSE, sep=";")
composition <- read.csv("data/processed/seed_composition.csv", check.names = FALSE, sep = ";")


# Extract genotype from Group column (remove "_R5" and "_R6") to match composicion table
phloem_R5 <- phloem_R5 %>% 
  mutate(Genotype = str_remove(Sample, "_R5"))

phloem_R6 <- phloem_R6 %>% 
  mutate(Genotype = str_remove(Sample, "_R6"))


# Join phloem metabolites with seed composition by genotype and remove redundant columns after join
R5_data <- left_join(phloem_R5, composition, by = c("Genotype" = "Sample")) %>%
  select(-Group.x, -Group.y)
R6_data <- left_join(phloem_R6, composition, by = c("Genotype" = "Sample")) %>%
  select(-Group.x, -Group.y)


# =============================================================================
# 2. Pearson correlations
# =============================================================================

# Define metabolite and composition columns
metabolites <- names(R5_data)[startsWith(names(R5_data), "met_")]
composition_vars <- names(composition)[-c(1,2)]


# Calculate Pearson correlation between metabolites and composition variables
calculate_correlations <- function(data, metabolites, composition_vars) {
  
  # Create empty matrices to store r and p values
  mat_r <- matrix(NA, nrow = length(metabolites), ncol = length(composition_vars),
                  dimnames = list(metabolites, composition_vars))
  mat_p <- mat_r
  
  # Loop through each metabolite and composition variable
  for (met in metabolites) {
    for (var in composition_vars) {
      
      # Calculate Pearson correlation and extract r and p
      test <- cor.test(data[[met]], data[[var]], method = "pearson")
      mat_r[met, var] <- test$estimate
      mat_p[met, var] <- test$p.value
    }
  }
  
  # Return both matrices as a list
  list(r = mat_r, p = mat_p)
}


# Calculate correlations for R5 and R6
corr_R5 <- calculate_correlations(data = R5_data, 
                                  metabolites = metabolites, 
                                  composition_vars = composition_vars)

corr_R6 <- calculate_correlations(data = R6_data, 
                                  metabolites = metabolites, 
                                  composition_vars = composition_vars)



# =============================================================================
# 3. Plot Heatmaps and Export figures
# =============================================================================

# Define significance matrix (r > 0.5 and p < 0.05)
signif_R5 <- ifelse(abs(corr_R5$r) > 0.5 & corr_R5$p < 0.05, "*", "")
signif_R6 <- ifelse(abs(corr_R6$r) > 0.5 & corr_R6$p < 0.05, "*", "")

# Heatmap R5
png("outputs/figures/heatmap_R5.png", width = 300, height = 800, res = 120)
pheatmap(
  corr_R5$r,
  color = colorRampPalette(rev(brewer.pal(11, "RdBu")))(100),
  breaks = seq(-1, 1, length.out = 101),
  display_numbers = signif_R5,
  number_color = "black",
  fontsize_number = 10,
  fontsize = 8,
  cluster_rows = T,
  cluster_cols = T,
  main = "Early seed filling (R5)"
)
dev.off()

# Heatmap R6
png("outputs/figures/heatmap_R6.png", width = 300, height = 800, res = 120)
pheatmap(
  corr_R6$r,
  color = colorRampPalette(rev(brewer.pal(11, "RdBu")))(100),
  breaks = seq(-1, 1, length.out = 101),
  display_numbers = signif_R6,
  number_color = "black",
  fontsize_number = 10,
  fontsize = 8,
  cluster_rows = T,
  cluster_cols = T,
  main = "Mid-Stage seed filling (R6)"
)
dev.off()


# =============================================================================
# 4. Top correlations table
# =============================================================================

get_top_correlations <- function(mat_r, mat_p, n = 5) {
  
  # Convert matrices to dataframe
  df_r <- as.data.frame(mat_r) %>%
    rownames_to_column("metabolite") %>%
    pivot_longer(-metabolite, names_to = "composition_var", values_to = "r")
  
  df_p <- as.data.frame(mat_p) %>%
    rownames_to_column("metabolite") %>%
    pivot_longer(-metabolite, names_to = "composition_var", values_to = "p")
  
  # Join r and p
  df <- left_join(df_r, df_p, by = c("metabolite", "composition_var"))
  
  # Filter significant and get top n per composition variable
  df %>%
    filter(p < 0.05) %>%
    mutate(abs_r = abs(r)) %>%
    group_by(composition_var) %>%
    slice_max(abs_r, n = n) %>%
    arrange(composition_var, desc(abs_r))
}

top_R5 <- get_top_correlations(corr_R5$r, corr_R5$p)
top_R6 <- get_top_correlations(corr_R6$r, corr_R6$p)

write.csv(top_R5, "outputs/tables/top_correlations_R5.csv", row.names = FALSE)
write.csv(top_R6, "outputs/tables/top_correlations_R6.csv",row.names = FALSE)
