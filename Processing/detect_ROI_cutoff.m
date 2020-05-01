function ana = detect_ROI_cutoff(frame, ana)

%if t==analysis_data.dt %determine cutoff based on first frame
%    pd = histfit(frame, 'normal'); %fit a normal distribution to the background intensities
%    cut_off_at_frame_1 = pd.mu+0.5*pd.sigma; %cutoff is at average plus 0.5 times std, for now, sigma is very big, so the result is not representative
%end
ana.other.sigma_first_frame=std(double(frame(:)));
ana.other.mu_first_frame=mean(double(frame(:)));
ana.other.cut_off_ROIs=ana.other.mu_first_frame+1*ana.other.sigma_first_frame;%cut_off_at_frame_1;
end