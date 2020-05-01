function ana = detect_ROIs(frame, ana, set)

if set.other.background_mode == 2
    factor = 0; 
end
   
for i=((ana.ROI.size-1)/2+1):(set.mic.pixels_y-(ana.ROI.size-1)/2)
    if sum(frame(i,:))>set.mic.pixels_x*set.other.av_background*factor %try if we can first see if anything happens in the row, by seeing if we have more intensity than could be expected from background
        for j=((ana.ROI.size-1)/2+1):(set.mic.pixels_x-(ana.ROI.size-1)/2) %loop over each matrix element in the frame that is NOT at the edge (at the edge, we don't want to define ROIs, as we here have insufficient info)
            if frame(i,j)>ana.other.cut_off_ROIs
                if ana.ROI.frame(i-1,j)==1||ana.ROI.frame(i+1,j)==1||ana.ROI.frame(i,j-1)==1||ana.ROI.frame(i,j+1)==1 %prevent neighbouring elements to have 1 values (we want a plasmonic particle to be in 1 ROI)
                    continue
                end
                if frame(i,j)<frame(i-1,j)||frame(i,j)<frame(i+1,j)||frame(i,j)<frame(i,j-1)||frame(i,j)<frame(i,j+1) %do not consider if any of its direct neighbours is bigger
                    continue %then it is a local maximum
                end
                ana.ROI.frame(i,j)=1; %1's in ROI_frame give the positions of the local maxima
            end
        end
    end
end