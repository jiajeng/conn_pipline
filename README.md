# conn_pipline

### step 1 &ensp; [Step1_conver2nii.m](/code/step1_convert2nii.m)
get .IMA file to local pc and convert to .nii file then upload to NAS  
read information from .nii file, save a MRIinfo.xlsx to store ImageSize,RT,sliceorder ... info.    
  
![image](https://github.com/user-attachments/assets/f010637b-6004-44e6-a7be-1fa054a03784)  
  
![image](https://github.com/user-attachments/assets/25640bcf-c247-4448-979a-93d636033cdf)  


### step 2 &ensp; [Step2_niiFile2local.m](/code/step2_niiFile2local.m)  
get .nii file to local pc
![image](https://github.com/user-attachments/assets/51b0e021-7006-4b70-bd04-ee458aac1b21)

### step 3 &ensp; [Step3_create_nproj.m](/code/step3_create_nproj.m)
create conn project and select run to which steps, save the progress in conn project path .xlsx file.  
> [!Note]
> not support change the setup data, like covariate or add subject, in exist conn project.
> for condition data analysis is not stable, need to check the condition definition in Setup process.

## HOW to use
- open main.m file
- check this two variable ![image](https://github.com/user-attachments/assets/7344759e-5c6c-474c-a042-93effd439241)
- run main.m file
- pop up this GUI for check the variable is right or not, can change in this GUI
- ![image](https://github.com/user-attachments/assets/f8ce4f6f-8a16-4c93-97d2-0335f706fd44)


