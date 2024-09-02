# conn-ToolBox

### step 1 &ensp; [Step1_conver2nii.m](/code/step1_convert2nii.m)
get .IMA file to local pc and convert to .nii file then upload to NAS, and save a MRIinfo.xlsx to store ImageSize,RT,sliceorder ... info.  
  
![image](https://github.com/user-attachments/assets/f010637b-6004-44e6-a7be-1fa054a03784)  
  
![image](https://github.com/user-attachments/assets/25640bcf-c247-4448-979a-93d636033cdf)  


### step 2 &ensp; [Step2_niiFile2local.m](/code/step2_niiFile2local.m)  
get .nii file to local pc
![image](https://github.com/user-attachments/assets/51b0e021-7006-4b70-bd04-ee458aac1b21)

### step 3 &ensp; [Step3_create_nproj.m](/code/step3_create_nproj.m)
create conn project and select run to which steps, save the progress in conn project path .xlsx file.  
> [!Note]
> not support change the setup data, like covariate or add subject, in exist conn project.
> for condition data analysis is not stable, need to check the progress.

## HOW to use
- open main.m file
- check this two variable ![image](https://github.com/user-attachments/assets/381b5649-4c90-47d2-9743-ff438580c05c)
- change your data variable in function def_nasorlocal(or not change later will let you to double check) ![image](https://github.com/user-attachments/assets/03c3f169-32c3-42cc-9c60-e27843124123)
- run main.m file
- pop up this GUI for check the variable is right or not, can change in this GUI
- ![image](https://github.com/user-attachments/assets/85536601-b46d-4acf-b0ee-8416fe131d11)

