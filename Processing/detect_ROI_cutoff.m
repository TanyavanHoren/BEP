function analysis_data = detect_ROI_cutoff(frame, analysis_data,t)

%if t==analysis_data.dt %determine cutoff based on first frame
%    pd = histfit(frame, 'normal'); %fit a normal distribution to the background intensities
%    cut_off_at_frame_1 = pd.mu+0.5*pd.sigma; %cutoff is at average plus 0.5 times std, for now, sigma is very big, so the result is not representative
%end
if t==analysis_data.dt
    analysis_data.sigma_first_frame=std(frame(:));
    analysis_data.mu_first_frame=mean(frame(:));
    analysis_data.cut_off_ROIs=analysis_data.mu_first_frame+5*analysis_data.sigma_first_frame;%cut_off_at_frame_1; 
end