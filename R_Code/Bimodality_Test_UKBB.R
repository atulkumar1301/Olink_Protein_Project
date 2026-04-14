library (data.table)
library(diptest)
library(ggplot2)
library(dplyr)

TABLE <- as.data.frame(matrix(ncol=3, nrow=2923))
names(TABLE) <- c("Protein", "Dip_Statistic", "P")

options(scipen = 999) ## To avoid scientific notation
df_Olink <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/7_Olink_Endocrine_Control.txt")

oldnames <- c ('ERVV-1', 'HLA-A', 'HLA-DRA', 'HLA-E')
newnames <- c ('ERVV_1', 'HLA_A', 'HLA_DRA', 'HLA_E')

df_Olink <- df_Olink %>% rename_at(vars (oldnames), ~ newnames)

df_2 <- df_Olink [,1:693]

j <- 1

for (i in colnames (df_Olink)){
  if (i %in% colnames (df_2)) next
  bimod_test <- dip.test (df_Olink [[i]], simulate=TRUE, B=5000)
  TABLE[j, 1] <- i
  TABLE[j, 2] <- bimod_test$statistic
  TABLE[j, 3] <- bimod_test$p.value
  
  j <- j + 1
}

write.table (TABLE, (file = paste0 ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/Results/UKBB_Data_Biomodality_Test.txt")), sep="\t", quote=FALSE, row.names=FALSE, col.names=TRUE)
