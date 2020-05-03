function ana = detect_ROIs(frame, ana, set)

if set.other.background_mode == 2
    factor = 0; 
end
   
for i=((ana.ROI.size-1)/2+1):(set.mic.pixels_y-(ana.ROI.size-1)/2) %ROIs are not detected at edge
    if sum(frame(i,:))>set.mic.pixels_x*set.other.av_background*factor %check if higher intensity in row than expected from background
        for j=((ana.ROI.size-1)/2+1):(set.mic.pixels_x-(ana.ROI.size-1)/2) 
            if frame(i,j)>ana.other.cut_off_ROIs
                if ana.ROI.frame(i-1,j)==1||ana.ROI.frame(i+1,j)==1||ana.ROI.frame(i,j-1)==1||ana.ROI.frame(i,j+1)==1 %prevention neighbouring 1's
                    continue
                end
                if frame(i,j)<frame(i-1,j)||frame(i,j)<frame(i+1,j)||frame(i,j)<frame(i,j-1)||frame(i,j)<frame(i,j+1) 
                    continue %then it is a local maximum
                end
                ana.ROI.frame(i,j)=1; %1's in ROI_frame give the positions of the local maxima
            end
        end
    end
end
end