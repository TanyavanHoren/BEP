function ch_data=rainSTORM_main(ch_data)

global rainSTORM_env
global rainSTORM_raw_stack

algo_name = ch_data.localization.algo_name;
settings = ch_data.localization.settings;

algo_names_and_handles = rainSTORM_default_settings_loc_algos;
algo_handle = algo_names_and_handles.fhandle{...
    strcmp(algo_names_and_handles.names,algo_name)==1};

tic
raw_stack_params = rainSTORM_read_stack(ch_data.rawdata_mgr,rainSTORM_env.is_tifflib_avail);
sizeOfCCDFrame = raw_stack_params.getFrameSize();
numberOfFrames = raw_stack_params.getNumberOfImages();

SupResParams = [];

parfor_progress_norm_factor = numberOfFrames / rainSTORM_env.parCompTool_NumWorkers;
clear parfor_progress_2
rainSTORM_parfor_progress(parfor_progress_norm_factor,1);
if rainSTORM_env.parCompTool
    parfor lpIm=1:numberOfFrames
        frame_to_process=rainSTORM_raw_stack(:,:,lpIm);
        SRP = rainSTORM_main_loop(lpIm,frame_to_process,algo_handle,settings);
        SupResParams = [SupResParams, SRP];
        rainSTORM_parfor_progress(parfor_progress_norm_factor);
    end
else
    for lpIm=1:numberOfFrames;
        frame_to_process=rainSTORM_raw_stack(:,:,lpIm);
        SRP = rainSTORM_main_loop(lpIm, frame_to_process,algo_handle,settings);
        SupResParams = [SupResParams, SRP];
        rainSTORM_parfor_progress(parfor_progress_norm_factor);
    end
end
rainSTORM_parfor_progress(parfor_progress_norm_factor,0);
toc

% Do offset correction if it is specified.
if isfield(ch_data, 'optoff_info') && ~isempty(ch_data.optoff_info)
    if ch_data.optoff_info.selected <= length(ch_data.optoff_info.optoff)
        settings_optoff.TFORM = ch_data.optoff_info.optoff(ch_data.optoff_info.selected).TFORM;
        SupResParams = rainSTORM_unOffset(SupResParams,settings_optoff);
        disp('Offset Correction was applied.')
    end
end

% Store results in channel data struct
ch_data.localization.results.sumFrame = uint32(sum(rainSTORM_raw_stack,3));
ch_data.localization.results.SupResParams = SupResParams;
ch_data.localization.results.numberOfFrames = numberOfFrames; % (Means number of frames)
ch_data.localization.results.numberOfLocs = length(SupResParams);
ch_data.rawdata_mgr.myImInfo.sizeOfCCDFrame = sizeOfCCDFrame; % Size of CCD image

% Store the raw CCD parameters for super resolved image reconstruction.
ch_data.reviewer{1,1}.settings.recon_algo_settings.sizeOfCCDFrame.val = sizeOfCCDFrame;
ch_data.reviewer{1,1}.settings.recon_algo_settings.pixelWidth.val = ...
    ch_data.rawdata_mgr.myImInfo.pixelWidth;

ch_data = rainSTORM_precision(ch_data);

end