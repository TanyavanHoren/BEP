function gmm_var = function_gmm(ana, set, ROIs, i, makePlot, rej)

gmm = fitgmdist([[ana.ROI(i).SupResParams.x_coord]'  [ana.ROI(i).SupResParams.y_coord]'],rej.number_gaussians); %give data, specify cluster number
gmm_var.idx = cluster(gmm,[[ana.ROI(i).SupResParams.x_coord]'  [ana.ROI(i).SupResParams.y_coord]']);
if makePlot == 1
    figure
    gscatter([ana.ROI(i).SupResParams.x_coord]',[ana.ROI(i).SupResParams.y_coord]',gmm_var.idx,'cmyb','o',1);
    hold on 
    plot_object_binding_spots(ROIs, set, i)
    legend('Cluster 1','Cluster 2');
    xlabel('x-position (pixels)')
    ylabel('y-position (pixels)')
    xlim([-set.ROI.size/2 set.ROI.size/2])
    ylim([([-set.ROI.size/2 set.ROI.size/2])])
    box on
    title('GMM')
end
end