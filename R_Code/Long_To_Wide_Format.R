library(data.table)
library(tidyr)
df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/NORNAL_Wellness_data_set/20211408_Magis_NPX_2022-01-24/20211408_Magis_NPX_2022-01-24.csv")
df_NPX <- df %>%
  pivot_wider(id_cols = c(SampleID, Index), names_from = Assay, values_from = NPX)


df_LOD <- df %>%
  pivot_wider(id_cols = c(SampleID, Index), names_from = Assay, values_from = LOD)

colnames (df_LOD) <- paste (colnames (df_LOD), "LOD", sep = "_")


df_QC_Warning <- df %>%
  pivot_wider(id_cols = c(SampleID, Index), names_from = Assay, values_from = QC_Warning)

colnames (df_QC_Warning) <- paste (colnames (df_QC_Warning), "QC_Warning", sep = "_")




df_3 <- apply(df_QC_Warning,2,as.character)



write.table (df_3, "~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/NORNAL_Wellness_data_set/20211408_Magis_NPX_2022-01-24/Olink_Protein_QC_Warning.txt", sep = "\t", row.names = FALSE)




li <- table (df_3$Assay)

list_1 <- c("CXCL8", "IDO1", "IL6", "LMOD1", "SCRIB", "TNF")

df_3 <- df |>
  dplyr::summarise(n = dplyr::n(), .by = c(SampleID, Index, Assay)) |>
  dplyr::filter(n > 1L)

df_prot_info <- subset (df, select = c (OlinkID, UniProt, Assay, MissingFreq, Panel, Panel_Lot_Nr, PlateID))
df_prot_info_unique <- df_prot_info [!duplicated(df_prot_info$UniProt)]

write.table(df_prot_info_unique, "~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/NORNAL_Wellness_data_set/20211408_Magis_NPX_2022-01-24/Protein_Info.txt", sep = "\t", row.names = FALSE)
