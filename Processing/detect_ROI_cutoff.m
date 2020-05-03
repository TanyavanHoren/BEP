function ana = detect_ROI_cutoff(frame, ana)

ana.other.sigma_first_frame=std(double(frame(:)));
ana.other.mu_first_frame=mean(double(frame(:)));
ana.other.cut_off_ROIs=ana.other.mu_first_frame+1*ana.other.sigma_first_frame;%cut_off_at_frame_1;
end