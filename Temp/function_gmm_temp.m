function idx = function_gmm_temp(ana, set, ROIs, i, makePlot, rej)

gm = fitgmdist([[ana.ROI(i).SupResParams.x_coord]'  [ana.ROI(i).SupResParams.y_coord]'],rej.number_gaussians); %give data, specify cluster number
idx = cluster(gm,[[ana.ROI(i).SupResParams.x_coord]'  [ana.ROI(i).SupResParams.y_coord]']);
if makePlot == 1
    figure
    gscatter([ana.ROI(i).SupResParams.x_coord]',[ana.ROI(i).SupResParams.y_coord]',idx);
    hold on
    if set.other.system_choice == 1
        viscircles([0 0],ROIs.ROI(i).object_radius/set.mic.pixelsize, 'LineWidth', 0.5);
    elseif set.other.system_choice == 2
        square = plot_square(ROIs, set, i);
    end
    legend('Cluster 1','Cluster 2');
    xlabel('x-position (pixels)')
    ylabel('y-position (pixels)')
    box on
    title('GMM')
end
end