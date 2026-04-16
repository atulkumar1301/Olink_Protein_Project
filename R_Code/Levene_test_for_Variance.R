library(data.table)
library(plyr)
library(dplyr)
library(tibble)
library(car)

TABLE <- as.data.frame(matrix(ncol=4, nrow=2923))
names(TABLE) <- c("Protein","DF", "F_value", "P")

df_Olink <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/7_Olink_Endocrine_Control.txt")

oldnames <- c ('ERVV-1', 'HLA-A', 'HLA-DRA', 'HLA-E')
newnames <- c ('ERVV_1', 'HLA_A', 'HLA_DRA', 'HLA_E')

df_Olink <- df_Olink %>% rename_at(vars (oldnames), ~ newnames)

d = "UKBB-Olink"
df_Olink <- add_column(df_Olink, Type = d, .after = 693)

df_wellness <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/NORNAL_Wellness_data_set/20211408_Magis_NPX_2022-01-24/Olink_Protein_Data.txt")
e = "Wellness-Olink"
df_wellness <- add_column(df_wellness, Type = e, .after = 2)

Olink_UKBB <- df_Olink [,-1:-693]
Olink_wellness <- df_wellness [, -1:-2]

df_Olink_wellness_merged <- bind_rows(Olink_UKBB, Olink_wellness)

df_2 <- df_Olink_wellness_merged [, 1]

j <- 1

for (i in colnames (df_Olink_wellness_merged)){
  if (i %in% colnames (df_2)) next
  result <- tryCatch ({leveneTest (df_Olink_wellness_merged [[i]] ~ df_Olink_wellness_merged$Type, na.rm = T)},
                      error = function (e) {
                        message("Protein", i, "not found", e$message)
                        return (NA)
                      })
  TABLE[j, 1] <- i
  TABLE[j, 2] <- tryCatch ({result$Df[1]},
                           error = function (f) {
                             message("No Value", f$message)
                             return (NA)
                           })
  TABLE[j, 3] <- tryCatch ({result$`F value`[1]},
                           error = function (f) {
                             message("No Value", f$message)
                             return (NA)
                           })
  TABLE[j, 4] <- tryCatch ({result$`Pr(>F)`[1]},
                           error = function (f) {
                             message("No Value", f$message)
                             return (NA)
                           })
  j <- j + 1
}

write.table (TABLE, (file = paste0 ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/Results/Levene_test_for_Variance.txt")), sep="\t", quote=FALSE, row.names=FALSE, col.names=TRUE)
