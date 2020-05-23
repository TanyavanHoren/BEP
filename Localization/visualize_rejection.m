function rejection_visualization_ellipse = visualize_rejection_ellipse(ana,i, set, ROIs, r_ellipse, ellipseParam)

figure
scatter([ana.ROI(i).loc.good_x],[ana.ROI(i).loc.good_y], 1, 'r');
hold on
%scatter([ana.ROI(i).loc.good_x],[ana.ROI(i).loc.good_y], 1, 'r');
    loc.ROI(i).x_s=[ROIs.ROI(i).site.position_x]/set.mic.pixelsize;
    loc.ROI(i).y_s=[ROIs.ROI(i).site.position_y]/set.mic.pixelsize;
    scatter(loc.ROI(i).x_s,loc.ROI(i).y_s,25, 'r','x');
    hold on
    if set.other.system_choice == 1
        viscircles([0 0],ROIs.ROI(i).object_radius/set.mic.pixelsize, 'LineWidth', 0.5);
    elseif set.other.system_choice == 2
        square = plot_square(ROIs, set, i);
    end
    plot(r_ellipse(:,1) + ellipseParam(5),r_ellipse(:,2) + ellipseParam(6),'-')
    xlabel('x-position (pixels)') 
    ylabel('y-position (pixels)') 
    box on 
end