library(tibble)
library(dplyr)
library(tidyr)
library(data.table)
library(PerformanceAnalytics)
library(Hmisc)

df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/NORNAL_Wellness_data_set/20211408_Magis_NPX_2022-01-24/Olink_Protein_Data.txt")
Olink_prot <- df[,-1:-2]

Cor_Matrix_Olink_prot <- rcorr(as.matrix(Olink_prot))

Cor_Matrix_Olink_prot_coef <- as.data.frame (Cor_Matrix_Olink_prot$r)
write.table (Cor_Matrix_Olink_prot_coef, "~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/NORNAL_Wellness_data_set/20211408_Magis_NPX_2022-01-24/Result/1_Olink_Protein_Cor_Matrix_coef.txt", row.names = TRUE, sep = "\t")

Cor_Matrix_Olink_prot_p_value <- as.data.frame (Cor_Matrix_Olink_prot$r)
write.table (Cor_Matrix_Olink_prot_p_value, "~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/NORNAL_Wellness_data_set/20211408_Magis_NPX_2022-01-24/Result/2_Olink_Protein_Cor_Matrix_p_value.txt", row.names = TRUE, sep = "\t")

# ++++++++++++++++++++++++++++
# flattenCorrMatrix
# ++++++++++++++++++++++++++++
# cormat : matrix of the correlation coefficients
# pmat : matrix of the correlation p-values
flattenCorrMatrix <- function(cormat, pmat) {
  ut <- upper.tri(cormat)
  data.frame(
    row = rownames(cormat)[row(cormat)[ut]],
    column = rownames(cormat)[col(cormat)[ut]],
    cor  =(cormat)[ut],
    p = pmat[ut]
  )
}

Olink_prot_flat_matrix <- flattenCorrMatrix(Cor_Matrix_Olink_prot$r, Cor_Matrix_Olink_prot$P)
write.table (Olink_prot_filtered_Matrix, "~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/NORNAL_Wellness_data_set/20211408_Magis_NPX_2022-01-24/Result/3_Olink_Protein_Flattened_Cor_Matrix.txt", row.names = FALSE, sep = "\t")

Olink_prot_filtered_Matrix <- subset(Olink_prot_flat_matrix, p < .05)
write.table (Olink_prot_filtered_Matrix, "~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/NORNAL_Wellness_data_set/20211408_Magis_NPX_2022-01-24/Result/4_Olink_Protein_Flattened_Cor_Matrix_Significant.txt", row.names = FALSE, sep = "\t")
