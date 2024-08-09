# conn-ToolBox

### step 1 &ensp; [Step1_conver2nii.m](/code/step1_convert2nii.m)
get .IMA file to local pc and convert to .nii file then upload to NAS  
![image](https://github.com/user-attachments/assets/5f8668a8-38f1-433b-8f01-1963ac1b82d7)

### step 2 &ensp; [Step2_niiFile2local.m](/code/step2_niiFile2local.m)  
get .nii file to local pc
![image](https://github.com/user-attachments/assets/51b0e021-7006-4b70-bd04-ee458aac1b21)

### step 3 &ensp; [Step3_create_nproj.m](/code/step3_create_nproj.m)
create conn project
#### For task
goal --> get denoising data(dswau*.nii)   
progress --> create each run(session E1 E2) conn project and run to Denoising step  

#### For Rest
goal --> get seed base connectivity result  
progress --> create Rest conn project and run all steps to second level  


### step 4 &ensp; Add ROI From Task data to REST conn project
using [Step3_create_nproj.m](/code/step3_create_nproj.m) to add roi


