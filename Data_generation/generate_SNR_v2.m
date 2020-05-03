function ana = generate_SNR_v2(ana, set)
%at each point in time add the average background times the pixel number in ROI
if set.other.background_mode == 2
    for i=1:ana.ROI.number
        timetrace(i,:) = ana.ROI.ROI(i).timetrace;
    end
    max_frame = set.mic.frames;
    ROIsize = ana.ROI.size;
    b = set.other.av_background;
    parfor i=1:ana.ROI.number
        for n_frame =1:max_frame
            timetrace(i,n_frame)=timetrace(i,n_frame)+poissrnd(ROIsize^2*b);
        end
    end
    
    for i=1:ana.ROI.number
        ana.ROI.ROI(i).timetrace = timetrace(i,:);
    end
end
end