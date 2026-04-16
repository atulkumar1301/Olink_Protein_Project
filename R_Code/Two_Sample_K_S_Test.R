library(dplyr)
library(tidyr)
library(data.table)
library(dgof)
TABLE <- as.data.frame(matrix(ncol=3, nrow=2923))
names(TABLE) <- c("Protein","K_S_D", "P")

df_Olink <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/7_Olink_Endocrine_Control.txt")

df_wellness <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/NORNAL_Wellness_data_set/20211408_Magis_NPX_2022-01-24/Olink_Protein_Data.txt")

oldnames <- c ('ERVV-1', 'HLA-A', 'HLA-DRA', 'HLA-E')
newnames <- c ('ERVV_1', 'HLA_A', 'HLA_DRA', 'HLA_E')

df_Olink <- df_Olink %>% rename_at(vars (oldnames), ~ newnames)

df_2 <- df_Olink [,1:693]

j <- 1

for (i in colnames (df_Olink)){
  if (i %in% colnames (df_2)) next
  kst <- tryCatch ({ks.test (df_Olink[[i]], df_wellness [[i]], na.rm = T)},
                   error = function (e) {
                     message("Protein", i, "not found", e$message)
                     return (NA)
                   })
  TABLE[j, 1] <- i
  TABLE[j, 2] <- tryCatch ({kst$statistic},
                           error = function (f) {
                             message("No Value", f$message)
                             return (NA)
                           })
  TABLE[j, 3] <- tryCatch ({kst$p.value},
                           error = function (f) {
                             message("No Value", f$message)
                             return (NA)
                           })
  j <- j + 1
}

write.table (TABLE, (file = paste0 ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/Results/Cumulative_Data_Distribution_Statistics.txt")), sep="\t", quote=FALSE, row.names=FALSE, col.names=TRUE)
