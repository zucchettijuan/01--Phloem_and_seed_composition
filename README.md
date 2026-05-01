# Phloem metabolites and soybean seed composition

Analysis of the relationship between phloem-delivered metabolites and seed quality parameters in contrasting soybean genotypes.


### Biological background

Soybean seed composition (protein and oil content) is largely determined by the supply of nutrients delivered to the embryo via phloem. This project explores correlations between phloem metabolitesmeasured at two developmental stages (R5 and R6) and the final protein and oil composition of mature seeds across six contrasting genotypes.

### Data

-   Phloem metabolites (GC-MS): 6 genotypes × 2 developmental stages (R5, R6) × 3 biological replicates

-   Data normalized and imputed in MetaboAnalyst (KNN imputation, square root transformation, auto scaling)

-   Seed composition: protein concentration and content measured by Kjeldahl in mature seeds

-   Metabolite identities have been anonymized due to data confidentiality. The analytical workflow and statistical structure remain unchanged.

Note: data/ folder not included pending publication.

### Analysis

-   Pearson correlations between phloem metabolites and seed composition variables

-   Heatmap visualization with significance threshold (\|r\| \> 0.5, p \< 0.05)

-   Top correlations extracted per composition variable

-   ROC analysis to identify metabolites with discriminatory power between high and low protein genotypes

## Conclusions

Phloem metabolite levels at both R5 and R6 developmental stages showed 
significant correlations with final seed composition parameters, suggesting 
that the supply of nutrients delivered to the embryo via phloem partially 
explains the variation in protein and oil content observed across genotypes.

A key finding is that protein concentration and protein content per seed 
are related but not equivalent traits — different metabolites correlate 
with each parameter independently, highlighting the importance of analyzing 
both parameters separately in breeding programs.

ROC analysis identified met_12 and met_01 as the metabolites with the 
highest discriminatory power between high and low protein genotypes at 
R5 and R6 stages respectively, suggesting these metabolites as potential 
early indicators of seed protein accumulation.

### Tools

R · tidyverse · pheatmap · RColorBrewer · pROC ·Quarto · MetaboAnalyst

### Status

Done \| Data pending publication
