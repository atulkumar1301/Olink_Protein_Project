library(data.table)
options(scipen = 999)
library(dplyr)
df_Olink <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/1_Olink_Data_Merged_Demographics.csv")

df_colname_change <- fread ("~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/2_Variable_Name_UKBB.txt")

oldnames <- df_colname_change$UDI
newnames <- df_colname_change$Description

df_Olink <- df_Olink %>% rename_at(vars (oldnames), ~ newnames)

df_Olink_1 <- subset(df_Olink, Diabetes_diagnosed_by_doctor_0 == 0)

df_Olink_2 <- subset(df_Olink_1, Cancer_diagnosed_by_doctor_0 == 0)

df_Olink_3 <- subset(df_Olink_2, Other_serious_medical_condition_disability_diagnosed_by_doctor_0 == 0)

write.table (df_Olink_3, "~/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/3_Olink_Data_Merged_Demographics.txt", row.names = FALSE, sep = "\t")
