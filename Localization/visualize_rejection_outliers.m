function rejection_visualization_outliers = visualize_rejection_outliers(ana,i, set, ROIs)

figure
%plot all points
scatter([ana.ROI(i).SupResParams.x_coord]',[ana.ROI(i).SupResParams.y_coord]', 1, 'r');
hold on
%plot non-outliers
scatter([ana.ROI(i).loc.good_x],[ana.ROI(i).loc.good_y], 1, 'g');
%draw actual particle shape
if set.other.system_choice == 1
    viscircles([0 0],ROIs.ROI(i).object_radius/set.mic.pixelsize, 'LineWidth', 0.5);
elseif set.other.system_choice == 2
    square = plot_square(ROIs, set, i);
end
xlabel('x-position (pixels)')
ylabel('y-position (pixels)')
box on
title('Outlier rejection')
end