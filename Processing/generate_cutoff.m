function ana = generate_cutoff(ana, set)

for i=1:ana.ROI.number
    pd = fitdist(ana.ROI.ROI(i).timetrace','Normal'); 
    ana.other.event_cutoff(i) = pd.mu+3*pd.sigma; 
    for n_frame = 1:set.mic.frames
        if ana.ROI.ROI(i).timetrace(n_frame)>ana.other.event_cutoff(i)
            ana.ROI.ROI(i).timetrace_disc(n_frame)=1;
        else 
            ana.ROI.ROI(i).timetrace_disc(n_frame)=0; 
        end
    end
end
end




