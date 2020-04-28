function intensity_data = count_intensity_ROIs_new(intensity_data, analysis_data, ROI_data, frame_data)

for i=1:ROI_data.number 
    lower_bound_x = ROI_data.ROI(i).position_x-(analysis_data.size_ROI-1)/2;%positions are in pixels and are independent of the frame
    upper_bound_x = ROI_data.ROI(i).position_x+(analysis_data.size_ROI-1)/2;
    lower_bound_y = ROI_data.ROI(i).position_y-(analysis_data.size_ROI-1)/2;
    upper_bound_y = ROI_data.ROI(i).position_y+(analysis_data.size_ROI-1)/2;
    for n_frame=1:analysis_data.frames %loop over all the frames
        A = frame_data(n_frame).frame([lower_bound_y:upper_bound_y], [lower_bound_x:upper_bound_x]); %create submatrix A containing the data in the ROI
        intensity_data.ROI(i).timetrace(n_frame) = sum(A, 'all'); %sum over all elements of submatrix A
    end
end


