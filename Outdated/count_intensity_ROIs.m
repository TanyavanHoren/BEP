function ana = count_intensity_ROIs(ana, frame, n_frame, obj)

for i=1:ana.ROI.number %loop over all objects, save each independently
    lower_bound_x = ana.ROI.ROI(i).position_x-(ana.ROI.size-1)/2;
    upper_bound_x = ana.ROI.ROI(i).position_x+(ana.ROI.size-1)/2;
    lower_bound_y = ana.ROI.ROI(i).position_y-(ana.ROI.size-1)/2;
    upper_bound_y = ana.ROI.ROI(i).position_y+(ana.ROI.size-1)/2;
%     for j=1:obj.gen.number
%         if lower_bound_x<obj.object(j).position_x<upper_bound_x && lower_bound_y<obj.object(j).position_y<upper_bound_y
%             ana.ROI.ROI(i).label=1; %if an object is present within the bounds, it is likely to be specific
%         else
%             ana.ROI.ROI(i).label=0;
%         end
%     end
    A = frame([lower_bound_y:upper_bound_y], [lower_bound_x:upper_bound_x]); %create submatrix A containing the data in the ROI
    ana.ROI.ROI(i).timetrace(n_frame) = sum(A, 'all'); %sum over all elements of submatrix A
end
