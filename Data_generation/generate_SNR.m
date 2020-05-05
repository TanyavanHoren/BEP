function ana = generate_SNR(ana, set)
%at each point in time add the average background times the pixel number in ROI
if set.other.background_mode == 2
    for i=1:ana.ROI.number
        timetrace(i,:) = ana.ROI.ROI(i).timetrace; %extract from struct
    end
    max_frame = set.mic.frames;
    ROI_size = ana.ROI.size;
    background_frame = set.sample.background_frame;
    parfor i=1:ana.ROI.number
        mean_background = background_frame(ana.ROI.ROI(i).position_y, ana.ROI.ROI(i).position_x)
        for n_frame =1:max_frame
            timetrace(i,n_frame)=timetrace(i,n_frame)+normrnd(ROI_size^2*mean_background,(-11.8+0.031*ROI_size^2*mean_background)*ROI_size);
        end
    end
    for i=1:ana.ROI.number
        ana.ROI.ROI(i).timetrace = timetrace(i,:); %place back in struct
    end
end
end