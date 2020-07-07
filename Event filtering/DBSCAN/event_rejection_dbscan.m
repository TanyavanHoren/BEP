function [ana, check] = event_rejection_dbscan(ana, i, set, ROIs, makePlot, k, check, rej)
tic
ana = reject_edge_points_dbscan(ana, i, rej);
[ana.ROI(i).SupResParams.isRej_DBSCAN]=ana.edge_points.logical{:}; 
dbscan_var = function_dbscan(ana, set, ROIs, i, makePlot, rej);
ana = merge_clusters(dbscan_var, set, i, ana, makePlot, ROIs);
check = determine_tf_pn(ana, i, k, check);
check(k).time = toc;
end