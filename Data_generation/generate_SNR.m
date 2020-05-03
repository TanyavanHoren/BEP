function ana = generate_SNR(ana, set)
%at each point in time add the average background times the pixel number in ROI
if set.other.background_mode == 2
    for i=1:ana.ROI.number
        for n_frame =1:set.mic.frames
        ana.ROI.ROI(i).timetrace(n_frame)=ana.ROI.ROI(i).timetrace(n_frame)+poissrnd(ana.ROI.size^2*set.other.av_background);  
        end
    end
end
end