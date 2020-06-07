function SupResParams = Matej_inspired_fitting_by_Dion(frame_data, set)

SupResParams=[];

parfor frame_number=1:set.mic.frames
    frame_to_process = frame_data(:,:,frame_number);
    SRP = process_frame(frame_to_process, set, frame_number); %find localizations
    SupResParams = [SupResParams, SRP];
end