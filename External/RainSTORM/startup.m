function rainSTORM_env = startup()

% [rainSTORM_dir,~,~] = fileparts(mfilename('fullpath'));
% addpath(genpath(rainSTORM_dir));
%calibration_tool_def_dir = [rainSTORM_dir,filesep,'calibrations',filesep,'optoff'];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Check for Bio-Formats library and startup it.
% bfCheckJavaPath function clears global variables, thus this has to be at
% the begining.
status_Bio_Formats = 0;
if exist('bfCheckJavaPath.m','file') == 2
    [status_Bio_Formats, ~] = bfCheckJavaPath(1);
else
    disp('Bioformats Disabled');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Global parameters
rainSTORM_env = struct(...
    'parCompTool',0,...
    'parCompTool_NumWorkers',1,...
    'imgProcTool',0,...
    'is_tifflib_avail',false,...
    'is_Bio_Formats_library_avail',status_Bio_Formats...
    );
%     'calibration_tool_def_dir',calibration_tool_def_dir,...
%     'rainSTORM_dir',rainSTORM_dir,...
%     'last_image_dir',rainSTORM_dir,...
if exist('tifflib','file') == 3
    rainSTORM_env.is_tifflib_avail = true;
end

v = ver;
for k=1:length(v)
    if strfind(v(k).Name, 'Parallel Computing Toolbox')
        rainSTORM_env.parCompTool = str2num((sprintf( v(k).Version)));
    end
    if strfind(v(k).Name, 'Image Processing Toolbox')
        rainSTORM_env.imgProcTool = str2num((sprintf( v(k).Version)));
    end
end
if rainSTORM_env.imgProcTool <= 0
    error('There is no Image Processing Toolbox installed!');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Start matlabpool if there is Parallel Computing Toolbox for R2014a or 
% greater and there is no active matlabpool.
if (rainSTORM_env.parCompTool >= 6.4000) && isempty(gcp('nocreate'))
    par_pool_data = gcp;
    rainSTORM_env.parCompTool_NumWorkers = par_pool_data.NumWorkers;
elseif ~isempty(gcp('nocreate'))
    disp('Parallel pool already running');
else
    disp('Parallel Computing Disabled');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create Params Struct with default parameter settings.
% params = rainSTORM_default_struct_params;
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Save params to the workspace
% assignin('base', 'params', params);
% disp('Startup complete!')
end

