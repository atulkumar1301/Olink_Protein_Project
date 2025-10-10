library(data.table)
library(ggplot2)
library(dplyr)
library(ggpubr)

df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/NORNAL_Wellness_data_set/20211408_Magis_NPX_2022-01-24/Protein_Info.txt")


p_full <- ggplot (df, aes (y = MissingFreq, x = reorder(X_axis, -MissingFreq), fill = Percent)) +
  geom_bar (stat = "identity")

p_full <- p_full + xlab ("Protein") + ylab ("Missing Frequency") + labs (fill = "Percentage of Missingness")

p_full <- p_full + scale_x_discrete(breaks = round (seq (1, 3000, by = 100), 1))

p_full <- p_full + 
  theme (axis.title.x = element_text(family = "serif", size = 14),
         axis.title.y = element_text(family = "serif", size = 14),
         axis.text.x = element_text(family = "serif", size = 14),
         axis.text.y = element_text(family = "serif", size = 14),
         legend.title = element_text(family = "serif", size = 14),
         legend.text = element_text(family = "serif", size = 14),
         panel.background = element_blank()) + labs (title = "Missingness in Olink Protein")
p_full
