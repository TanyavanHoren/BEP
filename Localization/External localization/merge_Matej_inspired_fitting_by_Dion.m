function SupResParams = merge_Matej_inspired_fitting_by_Dion(merged_frame_data, set,i,ana)

SupResParams=[];
parfor event_number=1:size(ana.ROI(i).timetrace_data.ontime,2)
    frame_to_process = merged_frame_data(:,:,event_number);
    SRP = merge_process_frame(frame_to_process, set, event_number); %find localizations
    SupResParams = [SupResParams, SRP];
end