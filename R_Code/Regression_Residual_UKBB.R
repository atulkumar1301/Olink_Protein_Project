library(data.table)
library(plyr)
library(dplyr)
library(tibble)
library(cowplot)
library(ggplot2)
library(ggpubr)


df_Olink <- fread ("~/OneDrive - University of Eastern Finland/Projects/Merja_Sui_Olink_Project/7_Olink_Endocrine_Control.txt")


oldnames <- c ('ERVV-1', 'HLA-A', 'HLA-DRA', 'HLA-E')
newnames <- c ('ERVV_1', 'HLA_A', 'HLA_DRA', 'HLA_E')

df_Olink <- df_Olink %>% rename_at(vars (oldnames), ~ newnames)

Olink_UKBB <- df_Olink [,1:693]

df_residual <- data.frame (row.names = rownames (df_Olink))

df_residual$EID <- df_Olink$EID

j <- 1

for (i in colnames (df_Olink)) {
  if (i %in% colnames (Olink_UKBB)) next
  N_P <- df_Olink[[i]]
  #lm_olink <- glm (N_P ~ Sex + Age_at_recruitment, data = df_Olink, family = gaussian, na.action = na.exclude)
  #lm_olink <- glm (N_P ~ Age_at_recruitment, data = df_Olink, family = gaussian, na.action = na.exclude)
  lm_olink <- glm (N_P ~ Sex, data = df_Olink, family = gaussian, na.action = na.exclude)
  res <- resid (lm_olink)
  df_residual[[i]] <- res
}
write.table (df_residual, (file = paste0 ("~/OneDrive - University of Eastern Finland/Projects/Merja_Sui_Olink_Project/Results/Residual_Sex.txt")), sep="\t", quote=FALSE, row.names=FALSE, col.names=TRUE)
