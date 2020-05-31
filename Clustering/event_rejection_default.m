function [ana, check] = event_rejection_default(ana, i, set, ROIs, makePlot, k, check)
tic;
[ana.ROI(i).SupResParams.isRej_DEFAULT]=ana.outlier.logical{:};
ana = reject_outside_ellipse(ana,i, set, ROIs, makePlot, k);
check = determine_tf_pn(ana, i, k, check);
check(k).time = toc;
end