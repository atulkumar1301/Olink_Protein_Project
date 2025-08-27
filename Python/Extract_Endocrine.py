ICD_Endocrine = []
for i in range (0, 91):
    if i < 10:
        ICD = "E0" + str(i)
        ICD_Endocrine.append(ICD)
    else:
        ICD = "E" + str(i)
        ICD_Endocrine.append(ICD)

f_m_Endocrine = open ("/Users/akumar/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/Olink_Endocrine.txt", 'w', 1)
f_m_Endocrine_Control = open ("/Users/akumar/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/Olink_Endocrine_Control.txt", 'w', 1)
with open ("/Users/akumar/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/8_Olink_Data_NPX_LOD.txt", 'r') as Olink_Data_file:
    line = Olink_Data_file.readline ()
    f_m_Endocrine.write (line)
    f_m_Endocrine_Control.write (line)
    for line in Olink_Data_file:
        c = 0
        for ICD_code in ICD_Endocrine:
            if ICD_code in line:
                f_m_Endocrine.write (line)
                c = c + 1
                break
        if c == 0:
            f_m_Endocrine_Control.write (line)
