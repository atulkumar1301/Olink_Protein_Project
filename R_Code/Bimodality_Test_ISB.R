library (data.table)
library(diptest)
library(ggplot2)
library(dplyr)

TABLE <- as.data.frame(matrix(ncol=3, nrow=2923))
names(TABLE) <- c("Protein", "Dip_Statistic", "P")

options(scipen = 999) ## To avoid scientific notation

df_wellness <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/NORNAL_Wellness_data_set/20211408_Magis_NPX_2022-01-24/Olink_Protein_Data.txt")


df_2 <- df_wellness [,1:2]

j <- 1

for (i in colnames (df_wellness)){
  if (i %in% colnames (df_2)) next
  bimod_test <- dip.test (df_wellness [[i]], simulate=TRUE, B=5000)
  TABLE[j, 1] <- i
  TABLE[j, 2] <- bimod_test$statistic
  TABLE[j, 3] <- bimod_test$p.value
  
  j <- j + 1
}

write.table (TABLE, (file = paste0 ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/NORNAL_Wellness_data_set/20211408_Magis_NPX_2022-01-24/Result/ISB_Data_Biomodality_Test.txt")), sep="\t", quote=FALSE, row.names=FALSE, col.names=TRUE)
