function idx = function_dbscan_temp(ana, set, ROIs, i, makePlot, rej)

idx = dbscan([[ana.ROI(i).SupResParams.x_coord]'  [ana.ROI(i).SupResParams.y_coord]'],rej.dbscan_eps,rej.dbscan_minPts);
if makePlot == 1
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
end