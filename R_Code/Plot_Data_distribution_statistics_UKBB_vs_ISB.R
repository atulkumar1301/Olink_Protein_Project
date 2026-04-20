library(data.table)
library(ggplot2)
library(ggrepel)
library(ggpubr)
library(ggpmisc)
df <- fread ("~/OneDrive - University of Eastern Finland/Projects/Merja_Sui_Olink_Project/Olink_Project_Results/eCDF_vs_Levene_Plot_Data.txt")

p <- ggscatter(df, x = "Skewness_UKBB", y = "Skewness_ISB", color = "green", size = 2, alpha = 0.6, ggtheme = theme_linedraw()) +
  geom_smooth(method = "lm", se = TRUE, color = "red", linetype = "dashed", fill = "blue") + # Add regression line
  stat_poly_eq(use_label(c("eq", "R2", "P")))  
p <- p + labs(title=expression("A) Skewness"), 
              x=expression("Skewness UKBB"), y=expression("Skewness ISB"))
p <- p + scale_x_continuous(breaks = round(seq(-6, 10, by = 2),1))
p <- p + scale_y_continuous(breaks = round (seq (-4, 10, by = 2), 1))
p <- p +
  theme(plot.title = element_text(family = "serif", size=14, face = "bold"),
        axis.title.x = element_text(family = "serif", size=13),
        axis.title.y = element_text(family = "serif", size=13),
        axis.text.x = element_text(family = "serif", size=12),
        axis.text.y = element_text(family = "serif", size=12),
        panel.background = element_blank())

p


##########
p1 <- ggscatter(df, x = "Kurtosis_UKBB", y = "Kurtosis_ISB", color = "green", size = 2, alpha = 0.6, ggtheme = theme_linedraw()) +
  geom_smooth(method = "lm", se = TRUE, color = "red", linetype = "dashed", fill = "blue") + # Add regression line
  stat_poly_eq(use_label(c("eq", "R2", "P")))  
p1 <- p1 + labs(title=expression("B) Kurtosis"), 
                x=expression("Kurtosis UKBB"), y=expression("Kurtosis ISB"))
p1 <- p1 + scale_x_continuous(breaks = round(seq(0, 260, by = 20),1))
p1 <- p1 + scale_y_continuous(breaks = round (seq (0, 120, by = 10), 1))
p1 <- p1+
  theme(plot.title = element_text(family = "serif", size=14, face = "bold"),
        axis.title.x = element_text(family = "serif", size=13),
        axis.title.y = element_text(family = "serif", size=13),
        axis.text.x = element_text(family = "serif", size=12),
        axis.text.y = element_text(family = "serif", size=12),
        panel.background = element_blank())

p1

##############

p2 <- ggplot(df, aes (x = -log10(P_UKBB), y = -log10(P_ISB))) + 
  geom_point (color = "green") + 
  geom_smooth(method = "lm", se = TRUE, color = "red", linetype = "dashed", fill = "blue") + # Add regression line
  stat_poly_eq(use_label(c("eq", "R2", "P")))  
p2 <- p2 + labs(title=expression("C) Jarque Bera P-Value"), 
                x=expression("Jarque Bera "*-log[10]~(P)* " UKBB"), y=expression("Jarque Bera "*-log[10]~(P)* " ISB"))
p2 <- p2 + scale_x_continuous(breaks = round(seq(0, 18, by = 2),1))
p2 <- p2 + scale_y_continuous(breaks = round (seq (0, 18, by = 2), 1))
p2 <- p2 + theme_linedraw()
p2 <- p2+
  theme(plot.title = element_text(family = "serif", size=14, face = "bold"),
        axis.title.x = element_text(family = "serif", size=13),
        axis.title.y = element_text(family = "serif", size=13),
        axis.text.x = element_text(family = "serif", size=12),
        axis.text.y = element_text(family = "serif", size=12),
        panel.background = element_blank(),
        panel.border = element_rect(colour = "black", fill = NA, linewidth = 1))

p2

###############

p3 <- ggplot(df, aes (x = Mean_UKBB, y = Mean_ISB)) + 
  geom_point (color = "green") + 
  geom_smooth(method = "lm", se = TRUE, color = "red", linetype = "dashed", fill = "blue") + # Add regression line
  stat_poly_eq(use_label(c("eq", "R2", "P")))  
p3 <- p3 + labs(title=expression("D) Mean"), 
                x=expression("Mean UKBB"), y=expression("Mean ISB"))
p3 <- p3 + scale_x_continuous(breaks = round(seq(-4, 2, by = 1),1))
p3 <- p3 + scale_y_continuous(breaks = round (seq (-8, 10, by = 2), 1))
p3 <- p3 + theme_linedraw()
p3 <- p3+
  theme(plot.title = element_text(family = "serif", size=14, face = "bold"),
        axis.title.x = element_text(family = "serif", size=13),
        axis.title.y = element_text(family = "serif", size=13),
        axis.text.x = element_text(family = "serif", size=12),
        axis.text.y = element_text(family = "serif", size=12),
        panel.background = element_blank(),
        panel.border = element_rect(colour = "black", fill = NA, linewidth = 1))

p3

###############

p4 <- ggplot(df, aes (x = Median_UKBB, y = Median_ISB)) + 
  geom_point (color = "green") + 
  geom_smooth(method = "lm", se = TRUE, color = "red", linetype = "dashed", fill = "blue") + # Add regression line
  stat_poly_eq(use_label(c("eq", "R2", "P")))  
p4 <- p4 + labs(title=expression("E) Median"), 
                x=expression("Median UKBB"), y=expression("Median ISB"))
p4 <- p4 + scale_x_continuous(breaks = round(seq(-1, 1, by = 0.2),1))
p4 <- p4 + scale_y_continuous(breaks = round (seq (-8, 10, by = 2), 1))
p4 <- p4 + theme_linedraw()
p4 <- p4+
  theme(plot.title = element_text(family = "serif", size=14, face = "bold"),
        axis.title.x = element_text(family = "serif", size=13),
        axis.title.y = element_text(family = "serif", size=13),
        axis.text.x = element_text(family = "serif", size=12),
        axis.text.y = element_text(family = "serif", size=12),
        panel.background = element_blank(),
        panel.border = element_rect(colour = "black", fill = NA, linewidth = 1))

p4

###############

p5 <- ggplot(df, aes (x = SD_UKBB, y = SD_ISB)) + 
  geom_point (color = "green") + 
  geom_smooth(method = "lm", se = TRUE, color = "red", linetype = "dashed", fill = "blue") + # Add regression line
  stat_poly_eq(use_label(c("eq", "R2", "P")))  
p5 <- p5 + labs(title=expression("E) SD"), 
                x=expression("SD UKBB"), y=expression("SD ISB"))
p5 <- p5 + scale_x_continuous(breaks = round(seq(-3, 3, by = 1),1))
p5 <- p5 + scale_y_continuous(breaks = round (seq (-7, 10, by = 1), 1))
p5 <- p5 + theme_linedraw()
p5 <- p5+
  theme(plot.title = element_text(family = "serif", size=14, face = "bold"),
        axis.title.x = element_text(family = "serif", size=13),
        axis.title.y = element_text(family = "serif", size=13),
        axis.text.x = element_text(family = "serif", size=12),
        axis.text.y = element_text(family = "serif", size=12),
        panel.background = element_blank(),
        panel.border = element_rect(colour = "black", fill = NA, linewidth = 1))

p5


plot <- ggarrange (p, p1, p2, p3, p4, p5)

annotate_figure(plot, top = text_grob(expression("Data distribution statistics of UKBB vs ISB"), color = "#999999", face = "bold", size = 18, family = "serif"))
