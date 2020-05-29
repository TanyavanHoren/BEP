function check = event_rejection_default(ana, i, set, ROIs, makePlot, k)
tic;
ana = reject_outside_ellipse(ana,i, set, ROIs, makePlot);
check = determine_tf_pn(ana, i, k);
check(k).time = toc;
end