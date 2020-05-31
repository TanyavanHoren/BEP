function dbscan_var = function_dbscan(ana, set, ROIs, i, makePlot, rej)

dbscan_var.idx = dbscan([ana.ROI(i).loc.good_x  ana.ROI(i).loc.good_y],rej.dbscan_eps,rej.dbscan_minPts);
if makePlot == 1
    figure
    gscatter(ana.ROI(i).loc.good(:,2),ana.ROI(i).loc.good(:,3),dbscan_var.idx,'rcmyb','o',1);
    hold on 
    plot_object_binding_spots(ROIs, set, i)
    xlabel('x-position (pixels)')
    ylabel('y-position (pixels)')
    box on
    title('DBSCAN')
end
end