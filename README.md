# 01- Phloem_and_seed_composition

Analysis of the relationship between phloem-delivered metabolites and seed quality parameters in contrasting soybean genotypes.

### Biological background

Soybean seed composition (protein and oil content) is largely determined by the supply of nutrients delivered to the embryo via phloem. This project explores correlations between phloem metabolitesmeasured at two developmental stages (R5 and R6) and the final protein and oil composition of mature seeds across six contrasting genotypes.

### Data

-   Phloem metabolites (GC-MS): 6 genotypes × 2 developmental stages (R5, R6) × 3 biological replicates

-   Data normalized and imputed in MetaboAnalyst (KNN imputation, square root transformation, auto scaling)

-   Seed composition: protein concentration and content measured by Kjeldahl in mature seeds

-   Metabolite names anonymized pending publication

### Analysis

-   Pearson correlations between phloem metabolites and seed composition variables

-   Heatmap visualization with significance threshold (\|r\| \> 0.5, p \< 0.05)

-   Top correlations extracted per composition variable

### Repository structure

Phloem_and_seed_composition/
├── data/processed/ ← normalized input data
├── outputs/figures/ ← exported heatmaps (PNG)
├── outputs/tables/ ← top correlation tables (CSV)
├── R/ ← analysis scripts
└── report.qmd ← Quarto report

### Tools

R · tidyverse · pheatmap · RColorBrewer · Quarto · MetaboAnalyst

### Status

Work in progress \| Data pending publication
