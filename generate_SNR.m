function intensity_data = generate_SNR(intensity_data,object_data,analysis_data, background_mode,n_frame, experiment_data)

if background_mode == 2
    for i=1:object_data.number
    intensity_data.object(i).timetrace(n_frame)=intensity_data.object(i).timetrace(n_frame)+poissrnd(analysis_data.size_ROI^2*experiment_data.average_background);
    end
end