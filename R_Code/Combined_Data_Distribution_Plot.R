library(data.table)
library(plyr)
library(dplyr)
library(tibble)
library(cowplot)
library(ggplot2)
library(ggpubr)
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

p1 <- 
  ggplot(df_Olink_wellness_merged) +
  aes_string(x = "A1BG", group = "Type", fill = "Type", color = "Type") +
  geom_histogram(aes (y=..density..), fill = "white", alpha = 0.5, position = "identity") +
  geom_density(alpha = 0.25, linetype = "dashed")
p1 <- p1 + theme(legend.title = element_text(family = "serif", size=5),
                 legend.text = element_text(family = "serif", size=5))

k = 1
for (i in seq (2, 2927, 98)){
  j = i + 97
  if (j < 2927) {
    Olink_prot_1 <- df_Olink_wellness_merged[,i:j]
    Olink_prot <- as.data.frame (cbind (Type = df_Olink_wellness_merged$Type, Olink_prot_1), na.rm = TRUE)
  }
  else {
    Olink_prot_1 <- df_Olink_wellness_merged[,i:2927]
    Olink_prot <- as.data.frame (cbind (Type = df_Olink_wellness_merged$Type, Olink_prot_1), na.rm = TRUE)
  }
  
  my_plots <- lapply(names(Olink_prot [,-1]), function(var_x){
    p <- 
      ggplot(Olink_prot) +
      aes_string(x = var_x, group = "Type", fill = "Type", color = "Type") +
      geom_histogram(aes (y=..density..), fill = "white", alpha = 0.5, position = "identity") +
      geom_density(alpha = 0.25, linetype = "dashed")
    p <- p + ylab ("Density")
    m <- aggregate(Olink_prot[[var_x]], list(Olink_prot$Type), mean, na.rm = TRUE)
    p <- p + geom_vline(xintercept=m$x, color= c ("blue", "red"), linetype = "longdash")
    p <- p + theme(plot.title = element_text(family = "serif", size=18, face = "bold"),
                   axis.title.x = element_text(family = "serif", size=8),
                   axis.title.y = element_text(family = "serif", size=8),
                   axis.text.x = element_text(family = "serif", size=5),
                   axis.text.y = element_text(family = "serif", size=5),
                   legend.title = element_text(family = "serif", size=5),
                   legend.position = "none",
                   legend.text = element_text(family = "serif", size=5))
  })
  legend <- get_legend(
    p1)
  pl <- plot_grid(plotlist = my_plots, legend) 
  ggsave (file = paste0 ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/Data_Distribution_Plot/", k, "_Data_Distribution_Plot.pdf"), plot = pl, width = 11.69, height = 8.27, units = "in")
  k = k + 1
}
