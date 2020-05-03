function ana = count_intensity_ROIs(ana, frame, n_frame)

for i=1:ana.ROI.number 
    ana.ROI.ROI(i).lower_bound_x = ana.ROI.ROI(i).position_x-(ana.ROI.size-1)/2;
    ana.ROI.ROI(i).upper_bound_x = ana.ROI.ROI(i).position_x+(ana.ROI.size-1)/2;
    ana.ROI.ROI(i).lower_bound_y = ana.ROI.ROI(i).position_y-(ana.ROI.size-1)/2;
    ana.ROI.ROI(i).upper_bound_y = ana.ROI.ROI(i).position_y+(ana.ROI.size-1)/2;
    A = frame([ana.ROI.ROI(i).lower_bound_y:ana.ROI.ROI(i).upper_bound_y], [ana.ROI.ROI(i).lower_bound_x:ana.ROI.ROI(i).upper_bound_x]); %create submatrix A containing the counts in the ROI
    ana.ROI.ROI(i).timetrace(n_frame) = sum(A, 'all'); %sum over all elements of submatrix A
end
end
