library(tibble)
library(dplyr)
library(tidyr)
library(data.table)
library(cowplot)
library(ggplot2)
df_Olink <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/7_Olink_Endocrine_Control.txt")

oldnames <- c ('ERVV-1', 'HLA-A', 'HLA-DRA', 'HLA-E')
newnames <- c ('ERVV_1', 'HLA_A', 'HLA_DRA', 'HLA_E')

df_Olink <- df_Olink %>% rename_at(vars (oldnames), ~ newnames)

d = "Case"
df_Olink <- add_column(df_Olink, Type = d, .after = 693)

df_wellness <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/NORNAL_Wellness_data_set/20211408_Magis_NPX_2022-01-24/Olink_Protein_Data.txt")
e = "Control"
df_wellness <- add_column(df_wellness, Type = e, .after = 2)

Olink_UKBB <- df_Olink [,-1:-693]
Olink_wellness <- df_wellness [, -1:-2]

df_Olink_wellness_merged <- bind_rows(Olink_UKBB, Olink_wellness)

k = 1
for (i in seq (2, 2927, 50)){
  j = i + 47
  if (j < 2927) {
    Olink_prot_1 <- df_Olink_wellness_merged[,i:j]
    Olink_prot <- as.data.frame (cbind (Type = df_Olink_wellness_merged$Type, Olink_prot_1), na.rm = TRUE)
  }
  else {
    Olink_prot_1 <- df_Olink_wellness_merged[,i:2927]
    Olink_prot <- as.data.frame (cbind (Type = df_Olink_wellness_merged$Type, Olink_prot_1), na.rm = TRUE)
  }
  
  my_plots <- lapply(names(Olink_prot), function(var_x){
    p <- 
      ggplot(Olink_prot) +
      aes_string(x = "Type", y = var_x) +
      geom_boxplot()
    #p <- p + ylab ("Density")
    p <- p + theme(plot.title = element_text(family = "serif", size=18, face = "bold"),
                   axis.title.x = element_text(family = "serif", size=8),
                   axis.title.y = element_text(family = "serif", size=8),
                   axis.text.x = element_text(family = "serif", size=5),
                   axis.text.y = element_text(family = "serif", size=5),
                   legend.title = element_text(family = "serif", size=5),
                   legend.text = element_text(family = "serif", size=5))
  })
  my_plots[1] <- NULL
  pl <- plot_grid(plotlist = my_plots) 
  ggsave (file = paste0 ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/NORNAL_Wellness_data_set/20211408_Magis_NPX_2022-01-24/Result/Box_Plots/", k, "_Box_Plot.pdf"), plot = pl, width = 11.69, height = 8.27, units = "in")
  k = k + 1
}
