% define step1 using local or nas folder
local = true; % your data is in local or in nas
check = true; % check input variable or not 
o = def_nasorlocal(local,check,true,false);

step1_convert2nii(o.sub,o.sess,o.round, ...
    'folder_nest',o.folder_nest, ...
    'subpath',o.subpath, ...
    'outsubpath',o.outsubpath, ...
    'ftpServer',o.ftpServer);
if ~local
    step2_niiFile2local(o.sess,o.round,o.ftpServer,o.folder_nest,o.outsubpath)
end

step3_create_nproj( o.conn_steps,o.conn_slice_order,...
    'sub',o.sub, ...
    'sess',o.conn_ses, ...
    'round',o.conn_round, ...
    'condition',o.conn_conditon, ...
    'conn_proj_name',o.conn_prjName, ...
    'conn_proj_path',o.conn_prjPath, ...
    'TR',o.conn_TR, ...
    'smooth_kernel',o.conn_fwhm, ...
    'StrucVres',o.conn_strVres, ...
    'funcVres',o.conn_funcVres, ...
    'filter_band',o.conn_filtBand, ...
    'analysisName',o.conn_AnalysisName, ...
    'mrifilepath',o.outsubpath,...
    'newprj',o.conn_rawdata, ...
    'sec_sub_efct',o.conn_2nd_sub_effect, ...
    'sec_sub_con',o.conn_2nd_sub_con, ...
    'sec_cond_efct',o.conn_2nd_cond_effect, ...
    'sec_cond_con',o.conn_2nd_cond_con, ...
    'secL_cov_name',o.cov_name, ...
    'secL_cov',o.cov_data, ...
    'ROI_path',o.conn_ROIpath)


function o = def_nasorlocal(local_flag,check_par,connF,ISCF)
    % --------------------------define raw data folder direction
    % nas server parameter
    ftpServer.ip = 'ftp://120.126.102.101/';
    ftpServer.account = 'jang05213127';
    ftpServer.password = 'nissen6034';
    ftpServer.infolder = 'LabData/jeng/test/RawData'; % Nas Raw Data folder 
                             %   e.x.LabData/廣達人腦健康資料庫
    ftpServer.outfolder = 'LabData/jeng/test/niiData'; % Nas put nii file folder
                              %   e.x.LabData/jeng/test/Data
    % ------------------------------------------------------------

    % -----------------------------define local path
    % local Raw Data folder 
    subpath = '.\..\Data';
    % local put nii file folder
    outsubpath = '.\..\Data';
    % ------------------------------------------------
    
    % ------------------------------define folder_nest
    % define folder nest sess and round are defined in variable sess and round, 
    % others is the folder name of user-defined
    % e.x. {'sess','mri','round'} --> sess_folder/'mri'/round_folder
    folder_nest = {'sess','mri','round'};
    % -----------------------------------------------

    % ----------------------------define sess and round
    sess = {'ses-01'};
    round = {'REST'};
    % -------------------------------------------------

    % ------------------------get subject Name
    % get age 20~30 subject
    % wordname_list = readtable("Q_n84.csv");
    % sub = wordname_list.ID;

    % get subject Name from Raw data folder 
    sub = {dir(outsubpath).name};
    sub = sub(contains(sub,'sub')|contains(sub,'SUB'));
    
    % get subject Name from Nas Raw data folder
    % ftpobj = ftp(ftpServer.ip,ftpServer.account,ftpServer.password);
    % cd(ftpobj,ftpServer.infolder);
    % SUBname = string({dir(ftpobj).name}');
    % SUBname = SUBname(contains(SUBname,'sub'));
    % close(ftpobj);
    % sub = SUBname;

    o.taskconditon = {''};
    o.Restconditon = {'REST'};
    % ----------------------------------------

    % ------------------------------CONN project
    o.conn_ses = '';
    o.conn_round = {'REST'};
    o.conn_prjName = ['conn_',cell2mat(o.conn_round),'_84'];
    o.conn_prjPath = fullfile('.\..\conn_proj\sub84',o.conn_prjName);
    % o.conn_steps = 'Denois_new';
    o.conn_steps =  struct("Setup",0, ...
                           "Preprocessing",0, ...
                           "Denoising",0, ...
                           "fst_Analysis",0, ...
                           "snd_Analysis",1, ...
                           "Add_Roi",0);

    % struct("Setup",0, ...
    %        "Preprocessing",0, ...
    %        "Denoising",0, ...
    %        "fst_Analysis",0, ...
    %        "snd_Analysis",0, ...
    %        "Add_Roi",1)
    if exist(fullfile(outsubpath,'MRinfo.xlsx'),'file')
        if connF
            empsub = cell(1,length(round));
            for roundi = 1:length(round)
                info = readtable(fullfile(outsubpath,'MRinfo.xlsx'),'Sheet',round{roundi}); 
                empsub{roundi} = string(info.subject)=="";
            end
            empsub = any(cell2mat(empsub),2);
            info = readtable(fullfile(outsubpath,'MRinfo.xlsx'),'Sheet',round{1}); 
            info = info(~empsub,:);
            sub = info.subject;

            o.conn_TR = unique(str2double(info.RT));
            o.conn_slice_order = str2num(unique(string(info.sliceorder))); % use str2num instead of str2double, using str2double will get nan
        else
            o.conn_TR = 0;
            o.conn_slice_order = '';
        end
        if size(o.conn_slice_order,1) > 1, o.conn_slice_order = o.conn_slice_order'; end
        if size(o.conn_TR,1) > 1
            error('infoData "TR" has different between subjects');
        end
        if size(o.conn_slice_order,1) > 1
            warning('infoData "sliceorder" has different between subject');
            o.conn_slice_order = '';
        end
    else
        o.conn_TR = 2.4;
        o.conn_slice_order = 'interleaved (bottom-up)';
    end
    
    tmp = readtable('Q_n84.csv');
    cov_name = tmp.Properties.VariableNames;
    cov_name = cov_name(~contains(cov_name,'ID') & ~contains(cov_name,'SEX') & ~contains(cov_name,'Education'));
    cov_data = tmp(:,cov_name);
    o.cov_name = {'AGE','ST_sim','ST_voc','ST_info','IR','SC_action','SC_obj','SC_Pass_acc'};
    o.cov_data = mat2cell(table2array(cov_data),size(cov_data,1),ones(1,size(cov_data,2)));

    o.conn_fwhm = 8;
    o.conn_strVres = 1;
    o.conn_funcVres = 2;
    o.conn_filtBand = [0.008, 0.09];
    o.conn_AnalysisName = 'SBC_01';
    % o.conn_contrast = {1};
    o.conn_ROIpath = '.\..\ROI_2';
    o.conn_conditon = {};
    o.conn_rawdata = true;
    o.conn_2nd_sub_effect = {{'AllSubjects','AGE','IR'},{'AllSubjects','AGE','ST_voc'},{'AllSubjects','AGE','ST_sim'},{'AllSubjects','AGE','ST_info'},{'AllSubjects','AGE','SC_action'},{'AllSubjects','AGE','SC_obj'},{'AllSubjects','AGE','SC_Pass_acc'}};
    o.conn_2nd_sub_con = {[0,0,1],[0,0,1],[0,0,1],[0,0,1],[0,0,1],[0,0,1],[0,0,1]};
    
    o.conn_2nd_cond_effect = {o.conn_round};
    o.conn_2nd_cond_con = {[1]};
    % ------------------------------------------

    if local_flag
        o.subpath = subpath;
        o.ftpServer = struct();
    else
        o.ftpServer = ftpServer;
        o.subpath = [];
    end
    o.outsubpath = outsubpath;
    o.folder_nest = folder_nest;
    o.sess = sess;
    o.round = round;
    o.sub = sub;
    if size(o.sess,2) ~= 1, o.sess = o.sess';end
    if size(o.round,2) ~= 1, o.round = o.round';end
    if size(o.sub,2) ~= 1, o.sub = o.sub';end
    o.done = false;
    if check_par
        o = checkGUI([],local_flag,o,connF,ISCF);
    end
end



