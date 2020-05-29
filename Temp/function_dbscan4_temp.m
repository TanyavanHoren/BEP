function idx = function_dbscan4_temp(ana, set, ROIs, i, makePlot, rej)

idx = dbscan([ana.ROI(i).loc.good_x_DBSCAN4  ana.ROI(i).loc.good_y_DBSCAN4],rej.dbscan_eps,rej.dbscan_minPts);
if makePlot == 1
    figure
    gscatter(ana.ROI(i).loc.good_DBSCAN4(:,2),ana.ROI(i).loc.good_DBSCAN4(:,3),idx);
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
end