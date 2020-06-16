function ana = determine_central_cluster(ana, gmm_var, i, makePlot, ROIs, set)
%predefine
x_1=0; 
counter_1=0;
x_2=0;
counter_2=0;
%determine the average absolute x-position of both clusters 
for l=1:size(gmm_var.idx,1)
    if gmm_var.idx(l) == 1
        x_1=x_1+abs(ana.ROI(i).SupResParams(l).x_coord);
        counter_1=counter_1+1;
    else
        x_2=x_2+abs(ana.ROI(i).SupResParams(l).x_coord);
        counter_2=counter_2+1;
    end
end
x_1_norm=x_1/counter_1; %average abs(x) of cluster 1
x_2_norm=x_2/counter_2; %average abs(x) of cluster 2
if x_1_norm>x_2_norm %the 'right' cluster is the one in the center
    gmm_var.idx_right=2;
else
    gmm_var.idx_right=1;
end
logical = num2cell(gmm_var.idx'~=gmm_var.idx_right.*ones(1,length(ana.ROI(i).SupResParams)));
[ana.ROI(i).SupResParams.isRej_GMM]=logical{:};

if makePlot == 1
    figure
    scatter([ana.ROI(i).SupResParams.x_coord]',[ana.ROI(i).SupResParams.y_coord]', 1, 'r');
    hold on 
    ana.ROI(i).loc.good_x_gmm_central = [ana.ROI(i).SupResParams.x_coord]'; %copy
    ana.ROI(i).loc.good_x_gmm_central = [ana.ROI(i).loc.good_x_gmm_central([ana.ROI(i).SupResParams.isRej_GMM]==0)]; %condition
    ana.ROI(i).loc.good_y_gmm_central = [ana.ROI(i).SupResParams.y_coord]';
    ana.ROI(i).loc.good_y_gmm_central = [ana.ROI(i).loc.good_y_gmm_central([ana.ROI(i).SupResParams.isRej_GMM]==0)]; %condition
    scatter([ana.ROI(i).loc.good_x_gmm_central],[ana.ROI(i).loc.good_y_gmm_central], 1, 'g');
    hold on 
    plot_object_binding_spots(ROIs, set, i);
    xlabel('x-position (pixels)')
    ylabel('y-position (pixels)')
    xlim([-set.ROI.size/2 set.ROI.size/2])
    ylim([([-set.ROI.size/2 set.ROI.size/2])])
    box on
    title('GMM central cluster')
end
end
