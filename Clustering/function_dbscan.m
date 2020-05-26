function DBSCAN = function_dbscan(ana, set, ROIs, i)

idx = dbscan([[ana.ROI(i).SupResParams.x_coord]'  [ana.ROI(i).SupResParams.y_coord]'],0.1,30);
figure
gscatter([ana.ROI(i).SupResParams.x_coord]',[ana.ROI(i).SupResParams.y_coord]',idx);
hold on
if set.other.system_choice == 1
    viscircles([0 0],ROIs.ROI(i).object_radius/set.mic.pixelsize, 'LineWidth', 0.5);
elseif set.other.system_choice == 2
    square = plot_square(ROIs, set, i);
end
xlabel('x-position (pixels)')
ylabel('y-position (pixels)')
box on
title('DBSCAN')
end