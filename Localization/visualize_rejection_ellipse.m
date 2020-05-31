function rejection_visualization_ellipse = visualize_rejection_ellipse(ana,i, set, ROIs, r_ellipse, k)

figure
scatter([ana.ROI(i).SupResParams.x_coord]',[ana.ROI(i).SupResParams.y_coord]', 1, 'r');
hold on
ana.ROI(i).loc.good_x_2 = [ana.ROI(i).SupResParams.x_coord]'; %copy
if k==1
    ana.ROI(i).loc.good_x_2 = [ana.ROI(i).loc.good_x_2([ana.ROI(i).SupResParams.isRej_DEFAULT]==0)]; %condition
elseif k==3
    ana.ROI(i).loc.good_x_2 = [ana.ROI(i).loc.good_x_2([ana.ROI(i).SupResParams.isRej_DBSCAN2]==0)]; %condition
elseif k==5
    ana.ROI(i).loc.good_x_2 = [ana.ROI(i).loc.good_x_2([ana.ROI(i).SupResParams.isRej_GMM2]==0)]; %condition
end
ana.ROI(i).loc.good_y_2 = [ana.ROI(i).SupResParams.y_coord]';
if k==1
    ana.ROI(i).loc.good_y_2 = [ana.ROI(i).loc.good_y_2([ana.ROI(i).SupResParams.isRej_DEFAULT]==0)];
elseif k==3
    ana.ROI(i).loc.good_y_2 = [ana.ROI(i).loc.good_y_2([ana.ROI(i).SupResParams.isRej_DBSCAN2]==0)];
elseif k==5
    ana.ROI(i).loc.good_y_2 = [ana.ROI(i).loc.good_y_2([ana.ROI(i).SupResParams.isRej_GMM2]==0)];
end
scatter([ana.ROI(i).loc.good_x_2],[ana.ROI(i).loc.good_y_2], 1, 'g');
hold on
plot_object_binding_spots(ROIs, set, i);
hold on 
plot(r_ellipse(:,1) ,r_ellipse(:,2),'-','Color','b')
xlabel('x-position (pixels)')
xlim([-(set.ROI.size-1)/4 (set.ROI.size-1)/4])
ylabel('y-position (pixels)')
ylim([-(set.ROI.size-1)/4 (set.ROI.size-1)/4])
box on
title('Error ellipse')
end