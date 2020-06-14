function [ana, check] = event_rejection_gmm(ana, i, set, ROIs, makePlot, k, check, rej)
tic
gmm_var = function_gmm(ana, set, ROIs, i, makePlot, rej);
<<<<<<< HEAD
ana = determine_central_cluster(ana, gmm_var, i, makePlot, ROIs, set);
check = determine_tf_pn(ana, i, k, check);
=======
if gmm_var.fit_failed==0
    ana = determine_central_cluster(ana, gmm_var, i, makePlot, ROIs, set);
    check = determine_tf_pn(ana, i, k, check);
else
    check(k).true_pos=NaN;
    check(k).true_neg=NaN;
    check(k).false_pos=NaN;
    check(k).false_neg=NaN;
end
>>>>>>> Merged-ROIs
check(k).time = toc;
end