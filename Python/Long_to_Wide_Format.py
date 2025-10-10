### This code converts long-format Olink Data to wide-format 
import pandas as pd
df = pd.read_csv ("/Users/akumar/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/NORNAL_Wellness_data_set/20211408_Magis_NPX_2022-01-24/20211408_Magis_NPX_2022-01-24.csv", delimiter=",")
df_1 = pd.pivot_table (df, index = ['SampleID', 'Index'], aggfunc = 'first')
df_1.to_csv ("/Users/akumar/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/NORNAL_Wellness_data_set/20211408_Magis_NPX_2022-01-24/Olink_New/Olink_Data_Normal_NPX.csv", sep=",", index=True)
