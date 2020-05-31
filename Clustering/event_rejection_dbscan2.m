function [ana, check] = event_rejection_dbscan2(ana, i, set, ROIs, makePlot, k, check, rej)
tic
[ana.ROI(i).SupResParams.isRej_DBSCAN2]=ana.outlier.logical{:}; 
dbscan_var = function_dbscan(ana, set, ROIs, i, makePlot, rej);
ana = merge_clusters(dbscan_var, set, i, rej, ana, k, makePlot, ROIs);
%Fit an error ellipse to the points within the merged cluster 
%Find all points within ellipse (also those not belonging to central cluster)
ana = reject_outside_ellipse(ana,i, set, ROIs, makePlot, k);
check = determine_tf_pn(ana, i, k, check);
check(k).time = toc;
end