function gmm_var = function_gmm(ana, set, ROIs, i, makePlot, rej)

mean_matrix=zeros(rej.number_gaussians,2);
if set.other.system_choice == 1
    sigma_matrix(:,:,1)=[set.obj.av_radius/set.mic.pixelsize 0; 0 set.obj.av_radius/set.mic.pixelsize];
elseif set.other.system_choice == 2
    sigma_matrix(:,:,1)=[(set.obj.av_size_x+set.obj.av_size_y)/(4*set.mic.pixelsize) 0; 0 (set.obj.av_size_x+set.obj.av_size_y)/(4*set.mic.pixelsize)];
end
sigma_matrix(:,:,2)=[set.ROI.size/2 0; 0 set.ROI.size/2];
S = struct('mu',mean_matrix,'Sigma',sigma_matrix);

try
    gmm = fitgmdist([[ana.ROI(i).SupResParams.x_coord]'  [ana.ROI(i).SupResParams.y_coord]'],rej.number_gaussians,'Start', S); %give data, specify cluster number
    gmm_var.fit_failed=0;
catch
    gmm_var.fit_failed=1; 
return 
end

gmm_var.idx = cluster(gmm,[[ana.ROI(i).SupResParams.x_coord]'  [ana.ROI(i).SupResParams.y_coord]']);
if makePlot == 1
    figure
    gscatter([ana.ROI(i).SupResParams.x_coord]',[ana.ROI(i).SupResParams.y_coord]',gmm_var.idx,'cmyb','o',1);
    %hold on 
    %plot_object_binding_spots(ROIs, set, i)
    legend('Cluster 1','Cluster 2');
    xlabel('x-position (pixels)')
    ylabel('y-position (pixels)')
    xlim([-set.ROI.size/2 set.ROI.size/2])
    ylim([([-set.ROI.size/2 set.ROI.size/2])])
    box on
    title('GMM')
end
end