function ana = count_intensity_ROIs(ana, set, frame, n_frame)

for i=1:ana.ROI.number %loop over all objects, save each independently
    lower_bound_x = ceil(ana.ROI.ROI(i).position_x/set.mic.pixelsize)-(ana.ROI.size-1)/2;
    upper_bound_x = ceil(ana.ROI.ROI(i).position_x/set.mic.pixelsize)+(ana.ROI.size-1)/2;
    lower_bound_y = ceil(ana.ROI.ROI(i).position_y/set.mic.pixelsize)-(ana.ROI.size-1)/2;
    upper_bound_y = ceil(ana.ROI.ROI(i).position_y/set.mic.pixelsize)+(ana.ROI.size-1)/2;
    A = frame([lower_bound_y:upper_bound_y], [lower_bound_x:upper_bound_x]); %create submatrix A containing the data in the ROI
    ana.ROI.ROI(i).timetrace(n_frame) = sum(A, 'all'); %sum over all elements of submatrix A
end
