function plot_object_binding_spots = plot_object_binding_spots(ROIs, set, i)

loc.ROI(i).x_s=[ROIs.ROI(i).site.position_x]/set.mic.pixelsize;
loc.ROI(i).y_s=[ROIs.ROI(i).site.position_y]/set.mic.pixelsize;
%scatter(loc.ROI(i).x_s,loc.ROI(i).y_s,25,'k','x');
hold on
if set.other.system_choice == 1
    viscircles([0 0],ROIs.ROI(i).object_radius/set.mic.pixelsize, 'LineWidth', 0.5, 'Color', 'Black');
elseif set.other.system_choice == 2
    square = plot_square(ROIs, set, i);
end
end