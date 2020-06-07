function [ana, check] = event_rejection_gmm(ana, i, set, ROIs, makePlot, k, check, rej)
tic
gmm_var = function_gmm(ana, set, ROIs, i, makePlot, rej);
ana = determine_central_cluster(ana, gmm_var, i, makePlot, ROIs, set);
check = determine_tf_pn(ana, i, k, check);
check(k).time = toc;
end