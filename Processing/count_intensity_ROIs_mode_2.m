function ana = count_intensity_ROIs_mode_2(ana, frame_data, set)

for i=1:ana.ROI.number
    ana.ROI.ROI(i).lower_bound_x = ana.ROI.ROI(i).position_x-(ana.ROI.size-1)/2;
    ana.ROI.ROI(i).upper_bound_x = ana.ROI.ROI(i).position_x+(ana.ROI.size-1)/2;
    ana.ROI.ROI(i).lower_bound_y = ana.ROI.ROI(i).position_y-(ana.ROI.size-1)/2;
    ana.ROI.ROI(i).upper_bound_y = ana.ROI.ROI(i).position_y+(ana.ROI.size-1)/2;
    for n_frame=1:set.mic.frames 
        A = frame_data(n_frame).frame([ana.ROI.ROI(i).lower_bound_y:ana.ROI.ROI(i).upper_bound_y], [ana.ROI.ROI(i).lower_bound_x:ana.ROI.ROI(i).upper_bound_x]); %create submatrix A with counts ROI
        ana.ROI.ROI(i).timetrace(n_frame) = sum(A, 'all'); %sum elements of submatrix A
    end
end



