library(tibble)
library(dplyr)
library(tidyr)
library(data.table)
library(cowplot)
library(ggplot2)
df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/7_Olink_Endocrine_Control.txt")

oldnames <- c ('ERVV-1', 'HLA-A', 'HLA-DRA', 'HLA-E')
newnames <- c ('ERVV_1', 'HLA_A', 'HLA_DRA', 'HLA_E')

df <- df %>% rename_at(vars (oldnames), ~ newnames)

k = 1
for (i in seq (694, 3616, 156)){
  j = i + 155
  if (j < 2921) {
    Olink_prot <- df[,i:j]
  }
  else {
    Olink_prot <- df[,i:3616]
  }
  
  my_plots <- lapply(names(Olink_prot), function(var_x){
    p <- 
      ggplot(Olink_prot) +
      aes_string(var_x) +
      geom_histogram(aes (y=..density..), colour = 1, fill = "white") +
      geom_density(lwd = 1, colour = 4, fill = 4, alpha = 0.25)
    p <- p + ylab ("Density")
    p <- p + theme(plot.title = element_text(family = "serif", size=18, face = "bold"),
                   axis.title.x = element_text(family = "serif", size=8),
                   axis.title.y = element_text(family = "serif", size=8),
                   axis.text.x = element_text(family = "serif", size=5),
                   axis.text.y = element_text(family = "serif", size=5),
                   legend.title = element_text(family = "serif", size=5),
                   legend.text = element_text(family = "serif", size=5))
  })
  
  pl <- plot_grid(plotlist = my_plots) 
  ggsave (file = paste0 ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/Results/Data_Distribution_Plot/", k, "_Data_Distribution_Plot.pdf"), plot = pl, width = 11.69, height = 8.27, units = "in")
  k = k + 1
}
