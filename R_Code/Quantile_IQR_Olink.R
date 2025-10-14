library(tibble)
library(dplyr)
library(tidyr)
library(data.table)
library(cowplot)
library(ggplot2)
df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/7_Olink_Endocrine_Control.txt")
Olink_prot_1 <- subset (df, Sex == 1)
Olink_prot_1 <- subset (df, Sex == 0) ##Female
Olink_prot <- Olink_prot_1 [,-1:-693]
df_q <- as.data.frame(sapply(Olink_prot, quantile, na.rm = TRUE))
df_IQR <- as.data.frame(t(as.data.frame(sapply(Olink_prot, IQR, na.rm = TRUE))))
df_Quantile <- bind_rows(df_q, df_IQR)

write.table (df_Quantile, "~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/Results/3_Qunatile_Data_Range_Males.txt", sep = "\t", row.names = TRUE)
