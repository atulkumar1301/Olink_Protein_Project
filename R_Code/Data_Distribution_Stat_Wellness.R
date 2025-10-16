library(dplyr)
library(tidyr)
library(data.table)
library(moments)
library(DescTools)
TABLE <- as.data.frame(matrix(ncol=8, nrow=2923))
names(TABLE) <- c("Protein", "Skewness", "Kurtosis","Jarque_Bera_Coef_chisq", "P", "Mean", "Median", "SD")

df_wellness <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/NORNAL_Wellness_data_set/20211408_Magis_NPX_2022-01-24/Olink_Protein_Data.txt")


df_2 <- df_wellness [,1:2]

j <- 1

for (i in colnames (df_wellness)){
  if (i %in% colnames (df_2)) next
  ske <- skewness (df_wellness [[i]], na.rm = T)
  kur <- kurtosis (df_wellness[[i]], na.rm = T)
  jar_t <- JarqueBeraTest (df_wellness[[i]], robust = TRUE, na.rm = T)
  TABLE[j, 1] <- i
  TABLE[j, 2] <- ske
  TABLE[j, 3] <- kur
  TABLE[j, 4] <- jar_t$statistic
  TABLE[j, 5] <- jar_t$p.value
  TABLE[j, 6] <- mean(df_wellness[[i]], na.rm = T)
  TABLE[j, 7] <- median(df_wellness[[i]], na.rm = T)
  TABLE[j, 8] <- sd(df_wellness[[i]], na.rm = T)
  
  j <- j + 1
}

write.table (TABLE, (file = paste0 ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/NORNAL_Wellness_data_set/20211408_Magis_NPX_2022-01-24/Result//Wellness_Data_Distribution_Statistics.txt")), sep="\t", quote=FALSE, row.names=FALSE, col.names=TRUE)
