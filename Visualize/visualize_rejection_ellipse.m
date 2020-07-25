function rejection_visualization_ellipse = visualize_rejection_ellipse(ana,i, set, ROIs, r_ellipse)

figure
scatter([ana.ROI(i).SupResParams.x_coord]',[ana.ROI(i).SupResParams.y_coord]', 1, 'r');
hold on
ana.ROI(i).loc.good_x_2 = [ana.ROI(i).SupResParams.x_coord]'; %copy
ana.ROI(i).loc.good_x_2 = [ana.ROI(i).loc.good_x_2([ana.ROI(i).SupResParams.isRej_DEFAULT]==0)]; %condition

ana.ROI(i).loc.good_y_2 = [ana.ROI(i).SupResParams.y_coord]';
ana.ROI(i).loc.good_y_2 = [ana.ROI(i).loc.good_y_2([ana.ROI(i).SupResParams.isRej_DEFAULT]==0)];

scatter([ana.ROI(i).loc.good_x_2],[ana.ROI(i).loc.good_y_2], 1, 'g');
%hold on
%plot_object_binding_spots(ROIs, set, i);
hold on
plot(r_ellipse(:,1) ,r_ellipse(:,2),'-','Color','b')
xlabel('x-position (pixels)')
xlim([-(set.ROI.size-1)/4 (set.ROI.size-1)/4])
ylabel('y-position (pixels)')
ylim([-(set.ROI.size-1)/4 (set.ROI.size-1)/4])
legend('Outside of ellipse', 'Inside of ellipse')
box on
title('Error ellipse')
end