library(data.table)
library(ggplot2)
library(tidyr)

options(scipen = 999) ## To avoid scientific notation
df <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/Olink_Nervous.txt")

#col_names <- as.data.frame (colnames (df))

#write.table (col_names, "~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/Column_Names.txt", sep = "\t", row.names = FALSE)

table (df$Sex)

#p <- ggplot (df, aes (x = Age_at_recruitment)) + geom_histogram (aes (y = after_stat(density)), color = "black", fill = "white", binwidth = 1) +
  #geom_density (alpha = 0.2, fill = "#FF6666")

p <- ggplot (df, aes (x = Age_at_recruitment)) + geom_histogram (color = "black", fill = "white", binwidth = 1)

p <- p + geom_vline(aes(xintercept = mean(Age_at_recruitment)), color = "blue", linetype = "dashed", linewidth = 1)

p <- p + scale_y_continuous(breaks = round (seq (0, 4000, by = 500), 1))

p <- p + xlab ("Age at Recruitment") + ylab ("Count")

p <- p + 
  theme (axis.title.x = element_text(family = "serif", size = 12),
         axis.title.y = element_text(family = "serif", size = 12),
         axis.text.x = element_text(family = "serif", size = 12),
         axis.text.y = element_text(family = "serif", size = 12),
         legend.title = element_text(family = "serif", size = 12),
         legend.text = element_text(family = "serif", size = 12),
         panel.background = element_blank()) + labs (title = "Case")
p <- p + theme_classic()

p
