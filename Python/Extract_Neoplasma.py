ICD_Neoplasma = []
for i in range (0, 98):
    if i < 10:
        ICD = "C0" + str(i)
        ICD_Neoplasma.append(ICD)
    else:
        ICD = "C" + str(i)
        ICD_Neoplasma.append(ICD)
for j in range (0, 49):
    if j < 10:
        ICD = "D0" + str(j)
        ICD_Neoplasma.append(ICD)
    else:
        ICD = "D" + str(j)
        ICD_Neoplasma.append(ICD)

f_m_Neoplasma = open ("/Users/akumar/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/Olink_Neoplasma.txt", 'w', 1)
f_m_Neoplasma_Control = open ("/Users/akumar/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/Olink_Neoplasma_Control.txt", 'w', 1)
with open ("/Users/akumar/Library/CloudStorage/OneDrive-UniversityofEasternFinland/Projects/Merja_Sui_Olink_Project/8_Olink_Data_NPX_LOD.txt", 'r') as Olink_Data_file:
    line = Olink_Data_file.readline ()
    f_m_Neoplasma.write (line)
    f_m_Neoplasma_Control.write (line)
    for line in Olink_Data_file:
        c = 0
        for ICD_code in ICD_Neoplasma:
            if ICD_code in line:
                f_m_Neoplasma.write (line)
                c = c + 1
                break
        if c == 0:
            f_m_Neoplasma_Control.write (line)
