function OPTICS = function_optics(ana, set, ROIs, i)

[RD,~,~]=optics([[ana.ROI(i).SupResParams.x_coord]'  [ana.ROI(i).SupResParams.y_coord]'],20);
copy=[[ana.ROI(i).SupResParams.x_coord]'  [ana.ROI(i).SupResParams.y_coord]'];
copy_filter(:,:) = copy(RD'<0.01,:);
figure
scatter(copy(:,1), copy(:,2),1,'r');
hold on
scatter(copy_filter(:,1), copy_filter(:,2),1,'g')
hold on
if set.other.system_choice == 1
    viscircles([0 0],ROIs.ROI(1).object_radius/set.mic.pixelsize, 'LineWidth', 0.5);
elseif set.other.system_choice == 2
    square = plot_square(ROIs, set, 1);
end
xlabel('x-position (pixels)')
ylabel('y-position (pixels)')
box on
title('OPTICS')
end