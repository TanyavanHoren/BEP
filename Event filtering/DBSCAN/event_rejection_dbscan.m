function [ana, check] = event_rejection_dbscan(ana, i, set, ROIs, makePlot, k, check, rej)
tic
[ana.ROI(i).SupResParams.isRej_DBSCAN]=ana.outlier.logical{:}; 
dbscan_var = function_dbscan(ana, set, ROIs, i, makePlot, rej);
ana = merge_clusters(dbscan_var, set, i, rej, ana, makePlot, ROIs);
check = determine_tf_pn(ana, i, k, check);
check(k).time = toc;
end