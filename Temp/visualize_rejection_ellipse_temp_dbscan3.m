function rejection_visualization_ellipse = visualize_rejection_ellipse_temp_dbscan3(ana,i, set, ROIs, r_ellipse)

figure
scatter([ana.ROI(i).SupResParams.x_coord]',[ana.ROI(i).SupResParams.y_coord]', 1, 'r');
hold on
ana.ROI(i).loc.good_x_DBSCAN3_2 = [ana.ROI(i).SupResParams.x_coord]'; %copy
ana.ROI(i).loc.good_x_DBSCAN3_2 = [ana.ROI(i).loc.good_x_DBSCAN3_2([ana.ROI(i).SupResParams.isOutlier_DBSCAN3]==0)]; %condition
ana.ROI(i).loc.good_y_DBSCAN3_2 = [ana.ROI(i).SupResParams.y_coord]';
ana.ROI(i).loc.good_y_DBSCAN3_2 = [ana.ROI(i).loc.good_y_DBSCAN3_2([ana.ROI(i).SupResParams.isOutlier_DBSCAN3]==0)];
scatter([ana.ROI(i).loc.good_x_DBSCAN3_2],[ana.ROI(i).loc.good_y_DBSCAN3_2], 1, 'g');
hold on 
loc.ROI(i).x_s=[ROIs.ROI(i).site.position_x]/set.mic.pixelsize;
loc.ROI(i).y_s=[ROIs.ROI(i).site.position_y]/set.mic.pixelsize;
scatter(loc.ROI(i).x_s,loc.ROI(i).y_s,25, 'r','x');
hold on
if set.other.system_choice == 1
    viscircles([0 0],ROIs.ROI(i).object_radius/set.mic.pixelsize, 'LineWidth', 0.5);
elseif set.other.system_choice == 2
    square = plot_square(ROIs, set, i);
end
plot(r_ellipse(:,1) ,r_ellipse(:,2),'-')
xlabel('x-position (pixels)')
ylabel('y-position (pixels)')
box on
title('Error ellipse')
end