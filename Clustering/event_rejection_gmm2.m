function [ana, check] = event_rejection_gmm2(ana, i, set, ROIs, makePlot, k, check, rej)
tic
gmm_var = function_gmm(ana, set, ROIs, i, makePlot, rej);
ana = determine_central_cluster(ana, gmm_var, i, k, makePlot, ROIs, set);
%Fit an error ellipse to the points within the 'right' cluster 
%Find all points within ellipse (also those not belonging to 'right' cluster)
ana = reject_outside_ellipse(ana,i, set, ROIs, makePlot, k);
check = determine_tf_pn(ana, i, k, check);
check(k).time = toc;
end
