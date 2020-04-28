function intensity_data = generate_SNR(intensity_data,ROI_data,analysis_data, background_mode, experiment_data)

if background_mode == 2
    for i=1:ROI_data.number
        for n_frame = 1:analysis_data.frames
        intensity_data.ROI(i).timetrace(n_frame)=intensity_data.ROI(i).timetrace(n_frame)+poissrnd(analysis_data.size_ROI^2*experiment_data.average_background);  
        end
    end
end