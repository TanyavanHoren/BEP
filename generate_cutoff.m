function intensity_data = generate_cutoff(intensity_data,analysis_data,object_data)

event_cutoff = zeros(1,object_data.number)';
for i=1:object_data.number
    pd = fitdist(intensity_data.object(i).timetrace(1:analysis_data.frames+1)','Normal'); %fit a normal distribution to a series of intensities
    intensity_data.event_cutoff(i) = pd.mu+0.5*pd.sigma; %cutoff is at average plus 0.5 times std, for now, sigma is very big, so the result is not representative
    for n_frame = 1:analysis_data.frames+1 
        if intensity_data.object(i).timetrace(n_frame)>intensity_data.event_cutoff(i)
            intensity_data.object(i).timetrace_disc(n_frame)=1;%everything above cutoff is considered an event
        else 
            intensity_data.object(i).timetrace_disc(n_frame)=0;%everything below cutoff is considered not an event
        end
    end
end




