library(tibble)
library(dplyr)
library(tidyr)
library(data.table)
library(cowplot)
library(ggplot2)
df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/NORNAL_Wellness_data_set/20211408_Magis_NPX_2022-01-24/Olink_Protein_Data.txt")
Olink_prot <- df [,-1:-2]

df_q <- as.data.frame(sapply(Olink_prot, quantile))
df_IQR <- as.data.frame(t(as.data.frame(sapply(Olink_prot, IQR))))
df_Quantile <- bind_rows(df_q, df_IQR)

write.table (df_Quantile, "~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/NORNAL_Wellness_data_set/20211408_Magis_NPX_2022-01-24/Result/5_Qunatile_Data_Range.txt", sep = "\t", row.names = TRUE)
