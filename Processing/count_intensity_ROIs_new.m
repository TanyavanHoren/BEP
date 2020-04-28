function ana = count_intensity_ROIs_new(ana, frame_data, set)

for i=1:ana.ROI.number 
    lower_bound_x = ana.ROI.ROI(i).position_x-(ana.ROI.size-1)/2;%positions are in pixels and are independent of the frame
    upper_bound_x = ana.ROI.ROI(i).position_x+(ana.ROI.size-1)/2;
    lower_bound_y = ana.ROI.ROI(i).position_y-(ana.ROI.size-1)/2;
    upper_bound_y = ana.ROI.ROI(i).position_y+(ana.ROI.size-1)/2;
    for n_frame=1:set.mic.frames %loop over all the frames
        A = frame_data(n_frame).frame([lower_bound_y:upper_bound_y], [lower_bound_x:upper_bound_x]); %create submatrix A containing the data in the ROI
        ana.ROI.ROI(i).timetrace(n_frame) = sum(A, 'all'); %sum over all elements of submatrix A
    end
end


