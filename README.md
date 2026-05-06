
# Phloem metabolites and soybean seed composition

## Objective

Identify phloem metabolites associated with final seed protein and oil
content in soybean, with potential application for early prediction of
grain quality traits in breeding programs

## Context

Seed composition in soybean is strongly influenced by carbon and
nitrogen supply during grain filling. This study evaluates whether
phloem metabolite profiles at key developmental stages (R5 and R6) can
be used to anticipate final seed protein and oil content across
contrasting genotypes.

### Data

-   Phloem metabolomics (GC-MS): 6 genotypes × 2 stages (R5, R6) × 3
    replicates
-   Seed composition (mature grains): protein and oil content
    (Kjeldahl-based measurements)
-   Metabolite features anonymized (structure preserved for analysis)

### Analysis

-   Data preprocessing: KNN imputation, square-root transformation,
    autoscaling (MetaboAnalyst)
-   Correlation analysis between metabolites and seed traits (protein,
    oil)
-   Feature prioritization based on correlation strength and statistical
    significance
-   Discriminatory analysis (ROC) to evaluate ability of metabolites to
    separate high vs low protein genotypes

## Conclusions

-   Several phloem metabolites showed strong association with final seed
    composition traits
-   Protein content and protein concentration behaved as partially
    independent traits, with distinct metabolic associations
-   Met_12 (R5) and Met_01 (R6) showed highest discriminatory power
    between high and low protein genotypes
-   Early-stage phloem profiles contain predictive signal of final grain
    composition

## Applied value

Phloem metabolite profiles during grain filling contain measurable
signals linked to final seed quality. Specific metabolites may serve as
early indicators of protein accumulation differences across genotypes,
with potential utility for:

-   Early selection in breeding programs
-   Reduction of time-to-phenotyping in quality traits
-   Integration into metabolomics-assisted selection pipelines

### Tools

R · tidyverse · pheatmap · RColorBrewer · pROC ·Quarto · MetaboAnalyst

### Status

Done \| Data pending publication
