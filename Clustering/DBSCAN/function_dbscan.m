function dbscan_var = function_dbscan(ana, set, ROIs, i, makePlot, rej)
%{
Cluster the event localizations using DBSCAN. 

INPUTS
-------
ana: struct containing results from analysis, such as the intermediate
    event classifications
set: system settings
ROIs: settings for the considered ROI specifically
i: index of the ROI considered
makePlot: do not make plot (if 0), or do make plot (if 1)
rej: settings for clustering, in this case the eps and minPts value used

OUTPUTS 
------
dbscan_var: intermediate results from DBSCAN analysis

Created by Tanya van Horen - July 2020
%}

%%
dbscan_var.idx = dbscan([ana.ROI(i).loc.non_edge_x  ana.ROI(i).loc.non_edge_y],rej.dbscan_eps,rej.dbscan_minPts);
if makePlot == 1
    figure
    gscatter(ana.ROI(i).loc.non_edge(:,2),ana.ROI(i).loc.non_edge(:,3),dbscan_var.idx,'rcmybgk','o',1);
    hold on 
    %plot_object_binding_spots(ROIs, set, i)
    xlabel('x-position (pixels)')
    ylabel('y-position (pixels)')
    xlim([-set.ROI.size/2 set.ROI.size/2])
    ylim([([-set.ROI.size/2 set.ROI.size/2])])
    legend('Outliers','Cluster 1','Cluster 2','Cluster 3', 'Cluster 4', 'Cluster 5', 'Cluster 6');
    box on
    title('DBSCAN')
end
end