function ana = detect_ROI_cutoff(frame, set, t, ana)

%if t==analysis_data.dt %determine cutoff based on first frame
%    pd = histfit(frame, 'normal'); %fit a normal distribution to the background intensities
%    cut_off_at_frame_1 = pd.mu+0.5*pd.sigma; %cutoff is at average plus 0.5 times std, for now, sigma is very big, so the result is not representative
%end
if t==set.mic.dt
    ana.other.sigma_first_frame=std(frame(:));
    ana.other.mu_first_frame=mean(frame(:));
    ana.other.cut_off_ROIs=ana.other.mu_first_frame+5*ana.other.sigma_first_frame;%cut_off_at_frame_1; 
end