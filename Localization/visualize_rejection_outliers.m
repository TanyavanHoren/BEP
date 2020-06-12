function rejection_visualization_outliers = visualize_rejection_outliers(ana,i, set, ROIs, median_x, median_y)

figure
%plot all points
scatter([ana.ROI(i).SupResParams.x_coord]',[ana.ROI(i).SupResParams.y_coord]', 1, 'r');
hold on
%plot non-outliers
scatter([ana.ROI(i).loc.good_x],[ana.ROI(i).loc.good_y], 1, 'g');
%draw actual particle shape
hold on 
plot_object_binding_spots(ROIs, set, i);
hold on 
scatter(median_x,median_y,'*')
xlabel('x-position (pixels)')
ylabel('y-position (pixels)')
xlim([-set.ROI.size/2 set.ROI.size/2])
ylim([([-set.ROI.size/2 set.ROI.size/2])])
box on
title('Outlier rejection')
end