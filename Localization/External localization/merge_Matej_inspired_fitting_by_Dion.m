function SupResParams = merge_Matej_inspired_fitting_by_Dion(merged_frame_data, set,i,ana)
%{
Localize the events in the merged frames. 

INPUTS
-------
merged_frame_data: merged frames 
set: system settings
i: index of considered ROI
ana: struct containing results from analysis

OUTPUTS 
------
SupResParams: all information extracted from event localization/Gaussian
fitting

Created by Dion Engels, fitting itself based on scripts Matej Hor?cek and
 Max Bergkamp - July 2020
%}

%%
SupResParams=[];
parfor event_number=1:size(ana.ROI(i).timetrace_data.ontime,2)
    frame_to_process = merged_frame_data(:,:,event_number);
    SRP = merge_process_frame(frame_to_process, set, event_number); %find localizations
    SupResParams = [SupResParams, SRP];
end