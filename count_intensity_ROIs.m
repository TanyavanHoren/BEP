function intensity_data = count_intensity_ROIs(intensity_data, analysis_data, object_data, pixel_data, frame, n_frame)

for i=1:object_data.number %loop over all objects, save each independently
    if object_data.object(i).analysis == 0
        continue
    end
    lower_bound_x = ceil(object_data.object(i).position_x/pixel_data.pixelsize)-(analysis_data.size_ROI-1)/2;
    upper_bound_x = ceil(object_data.object(i).position_x/pixel_data.pixelsize)+(analysis_data.size_ROI-1)/2;
    lower_bound_y = ceil(object_data.object(i).position_y/pixel_data.pixelsize)-(analysis_data.size_ROI-1)/2;
    upper_bound_y = ceil(object_data.object(i).position_y/pixel_data.pixelsize)+(analysis_data.size_ROI-1)/2;
    A = frame([lower_bound_y:upper_bound_y], [lower_bound_x:upper_bound_x]); %create submatrix A containing the data in the ROI
    intensity_data.object(i).timetrace(n_frame) = sum(A, 'all'); %sum over all elements of submatrix A
end  