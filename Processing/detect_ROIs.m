function ROI_frame = detect_ROIs(frame, ROI_frame, analysis_data, pixel_data)

for i=((analysis_data.size_ROI-1)/2+1):(pixel_data.pixels_y-(analysis_data.size_ROI-1)/2)
    for j=((analysis_data.size_ROI-1)/2+1):(pixel_data.pixels_x-(analysis_data.size_ROI-1)/2) %loop over each matrix element in the frame that is NOT at the edge (at the edge, we don't want to define ROIs, as we here have insufficient info)
        if ROI_frame(i-1,j)==1||ROI_frame(i+1,j)==1||ROI_frame(i,j-1)==1||ROI_frame(i,j+1)==1 %prevent neighbouring elements to have 1 values (we want a plasmonic particle to be in 1 ROI)
            continue
        end
        if frame(i,j)>analysis_data.cut_off_ROIs %if the value of the frame is above the cut_off, we must consider if it is a local maximum
            if frame(i,j)<frame(i-1,j)||frame(i,j)<frame(i+1,j)||frame(i,j)<frame(i,j-1)||frame(i,j)<frame(i,j+1) %do not consider if any of its direct neighbours is bigger
                continue %then it is a local maximum
            end
            ROI_frame(i,j)=1; %1's in ROI_frame give the positions of the local maxima
        end
    end
end
