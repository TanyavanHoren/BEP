function intensity_data = generate_cutoff(intensity_data,analysis_data,ROI_data)

event_cutoff = zeros(1,ROI_data.number)';
for i=1:ROI_data.number
    pd = fitdist(intensity_data.ROI(i).timetrace','Normal'); %fit a normal distribution to a series of intensities
    intensity_data.event_cutoff(i) = pd.mu+0.5*pd.sigma; %cutoff is at average plus 0.5 times std, for now, sigma is very big, so the result is not representative
    for n_frame = 1:analysis_data.frames
        if intensity_data.ROI(i).timetrace(n_frame)>intensity_data.event_cutoff(i)
            intensity_data.ROI(i).timetrace_disc(n_frame)=1;%everything above cutoff is considered an event
        else 
            intensity_data.ROI(i).timetrace_disc(n_frame)=0;%everything below cutoff is considered not an event
        end
    end
end




