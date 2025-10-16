library(dplyr)
library(tidyr)
library(data.table)
library(moments)
library(DescTools)
TABLE <- as.data.frame(matrix(ncol=8, nrow=2923))
names(TABLE) <- c("Protein", "Skewness", "Kurtosis","Jarque_Bera_Coef_chisq", "P", "Mean", "Median", "SD")

df_Olink <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/7_Olink_Endocrine_Control.txt")

oldnames <- c ('ERVV-1', 'HLA-A', 'HLA-DRA', 'HLA-E')
newnames <- c ('ERVV_1', 'HLA_A', 'HLA_DRA', 'HLA_E')

df_Olink <- df_Olink %>% rename_at(vars (oldnames), ~ newnames)

df_2 <- df_Olink [,1:693]

j <- 1

for (i in colnames (df_Olink)){
  if (i %in% colnames (df_2)) next
  ske <- skewness (df_Olink [[i]], na.rm = T)
  kur <- kurtosis (df_Olink[[i]], na.rm = T)
  jar_t <- JarqueBeraTest (df_Olink[[i]], robust = TRUE, na.rm = T)
  TABLE[j, 1] <- i
  TABLE[j, 2] <- ske
  TABLE[j, 3] <- kur
  TABLE[j, 4] <- jar_t$statistic
  TABLE[j, 5] <- jar_t$p.value
  TABLE[j, 6] <- mean(df_Olink[[i]], na.rm = T)
  TABLE[j, 7] <- median(df_Olink[[i]], na.rm = T)
  TABLE[j, 8] <- sd(df_Olink[[i]], na.rm = T)
  
  j <- j + 1
}

write.table (TABLE, (file = paste0 ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/Results/UKBB_Data_Distribution_Statistics.txt")), sep="\t", quote=FALSE, row.names=FALSE, col.names=TRUE)
