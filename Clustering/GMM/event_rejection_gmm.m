function [ana, check] = event_rejection_gmm(ana, i, set, ROIs, makePlot, k, check, rej)
tic
gmm_var = function_gmm(ana, set, ROIs, i, makePlot, rej);
if gmm_var.fit_failed==0
    ana = determine_central_cluster(ana, gmm_var, i, makePlot, ROIs, set);
else
    logical = num2cell(false(1,size(ana.ROI(i).SupResParams,2)));
    [ana.ROI(i).SupResParams.isRej_GMM]=logical{:};
end
check = determine_tf_pn(ana, i, k, check);
check(k).time = toc;
end