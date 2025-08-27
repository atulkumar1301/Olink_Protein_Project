ICD_Nervous = []
for i in range (0, 100):
    if i < 10:
        ICD = "G0" + str(i)
        ICD_Nervous.append(ICD)
    else:
        ICD = "G" + str(i)
        ICD_Nervous.append(ICD)

f_m_Nervous = open ("/Users/akumar/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/Olink_Nervous.txt", 'w', 1)
f_m_Nervous_Control = open ("/Users/akumar/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/Olink_Nervous_Control.txt", 'w', 1)
with open ("/Users/akumar/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/8_Olink_Data_NPX_LOD.txt", 'r') as Olink_Data_file:
    line = Olink_Data_file.readline ()
    f_m_Nervous.write (line)
    f_m_Nervous_Control.write (line)
    for line in Olink_Data_file:
        c = 0
        for ICD_code in ICD_Nervous:
            if ICD_code in line:
                f_m_Nervous.write (line)
                c = c + 1
                break
        if c == 0:
            f_m_Nervous_Control.write (line)
