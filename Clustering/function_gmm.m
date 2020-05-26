function gaussian_mixture_model = function_gmm(ana, set, ROIs, i)

gm = fitgmdist([[ana.ROI(i).SupResParams.x_coord]'  [ana.ROI(i).SupResParams.y_coord]'],2); %give data, specify cluster number
idx = cluster(gm,[[ana.ROI(i).SupResParams.x_coord]'  [ana.ROI(i).SupResParams.y_coord]']);
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