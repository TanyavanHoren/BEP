function ana = generate_cutoff(ana, set)

event_cutoff = zeros(1,ana.ROI.number)';
for i=1:ana.ROI.number
    pd = fitdist(ana.ROI.ROI(i).timetrace','Normal'); %fit a normal distribution to a series of intensities
    ana.other.event_cutoff(i) = pd.mu+2*pd.sigma; %cutoff is at average plus 5 times std, for now, sigma is very big, so the result is not representative
    for n_frame = 1:set.mic.frames
        if ana.ROI.ROI(i).timetrace(n_frame)>ana.other.event_cutoff(i)
            ana.ROI.ROI(i).timetrace_disc(n_frame)=1;%everything above cutoff is considered an event
        else 
            ana.ROI.ROI(i).timetrace_disc(n_frame)=0;%everything below cutoff is considered not an event
        end
    end
end




