library(data.table)
library(dplyr)
library(tibble)
library(cowplot)
library(ggplot2)
library(ggpubr)

# Load datasets safely
df_Olink <- fread("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/7_Olink_Endocrine_Control.txt")
df_wellness <- fread("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/NORNAL_Wellness_data_set/20211408_Magis_NPX_2022-01-24/Olink_Protein_Data.txt")

# Rename columns safely using standard dplyr
oldnames <- c('ERVV-1', 'HLA-A', 'HLA-DRA', 'HLA-E')
newnames <- c('ERVV_1', 'HLA_A', 'HLA_DRA', 'HLA_E')
df_Olink <- df_Olink %>% rename_with(~ newnames, all_of(oldnames))

# Create cohort/sex identifiers
d <- ifelse(df_Olink$Sex == 1, "UKBB-Olink-Male", "UKBB-Olink-Female") 
df_Olink <- add_column(df_Olink, Type = d, .after = 693)

e <- ifelse(df_wellness$Sex == "M", "Wellness-Olink-Male", "Wellness-Olink-Female")
df_wellness <- add_column(df_wellness, Type = e, .after = 2)

# Keep only necessary data (retaining the Type column)
Olink_UKBB <- df_Olink[, -c(1:693)]
Olink_wellness <- df_wellness[, -c(1:2)]

# Merge datasets
df_Olink_wellness_merged <- bind_rows(Olink_UKBB, Olink_wellness)
# Explicitly cast to data.frame to ensure standard column indexing operations work flawlessly
df_Olink_wellness_merged <- as.data.frame(df_Olink_wellness_merged)

# Set global shared text theme configuration for clean layouts
plot_theme <- theme_minimal() + 
  theme(
    plot.title = element_text(family = "serif", size = 8, face = "bold"),
    axis.title.x = element_text(family = "serif", size = 8),
    axis.title.y = element_text(family = "serif", size = 8),
    axis.text.x = element_text(family = "serif", size = 5),
    axis.text.y = element_text(family = "serif", size = 5),
    legend.position = "none"
  )

# Loop over chunks of 9 proteins
k <- 1
for (i in seq(2, 2924, 9)) {
  j <- min(i + 8, 2924) # Automatically prevents indexing out of bounds
  
  # Extract current chunk
  Olink_prot_1 <- df_Olink_wellness_merged[, i:j, drop = FALSE]
  Olink_prot <- cbind(Type = df_Olink_wellness_merged$Type, Olink_prot_1)
  
  # Generate isolated 4-panel subplots per protein
  my_plots <- lapply(names(Olink_prot)[-1], function(var_x) {
    
    # Calculate the global min and max for the current protein across all groups
    # na.rm = TRUE ensures missing values don't break the limits
    x_min <- min(Olink_prot[[var_x]], na.rm = TRUE)
    x_max <- max(Olink_prot[[var_x]], na.rm = TRUE)
    
    p1 <- ggplot(subset(Olink_prot, Type == "UKBB-Olink-Male"), aes(x = .data[[var_x]])) +
      geom_histogram(aes(y = after_stat(density)), bins = 30, fill = "gray", color = "white") +
      geom_density(color = "red", linewidth = 1) +
      labs(title = "UKBB-Male", y = "Density") +
      xlim(x_min, x_max) + plot_theme # Forces the unified x-axis scale
    
    p2 <- ggplot(subset(Olink_prot, Type == "Wellness-Olink-Male"), aes(x = .data[[var_x]])) +
      geom_histogram(aes(y = after_stat(density)), bins = 30, fill = "gray", color = "white") +
      geom_density(color = "blue", linewidth = 1) +
      labs(title = "ISB-Male", y = "Density") + 
      xlim(x_min, x_max) + plot_theme
    
    p3 <- ggplot(subset(Olink_prot, Type == "UKBB-Olink-Female"), aes(x = .data[[var_x]])) +
      geom_histogram(aes(y = after_stat(density)), bins = 30, fill = "gray", color = "white") +
      geom_density(color = "green", linewidth = 1) +
      labs(title = "UKBB-Female", y = "Density") + 
      xlim(x_min, x_max) + plot_theme
    
    p4 <- ggplot(subset(Olink_prot, Type == "Wellness-Olink-Female"), aes(x = .data[[var_x]])) +
      geom_histogram(aes(y = after_stat(density)), bins = 30, fill = "gray", color = "white") +
      geom_density(color = "purple", linewidth = 1) +
      labs(title = "ISB-Female", y = "Density") + 
      xlim(x_min, x_max) + plot_theme
    
    # Pack the 4 panels together for this single protein
    ggarrange(p1, p2, p3, p4, ncol = 2, nrow = 2)
  })
  
  # Combine up to 9 compiled protein multi-panels into a 3x3 layout page
  pl <- plot_grid(plotlist = my_plots, ncol = 3, nrow = 3) 
  
  # Save the finalized multi-panel PDF document
  ggsave (file = paste0 ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/Modality_Plot_Sex_Based/", k, "_Modality_Plot.pdf"), plot = pl, width = 11.69, height = 8.27, units = "in")

  k <- k + 1
}
