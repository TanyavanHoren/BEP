function ana = merge_clusters(dbscan_var, set, i, rej, ana, makePlot, ROIs)

%find how many points are identified per cluster 
[num_per_index_dbscan,indices_dbscan] = groupcounts(dbscan_var.idx);
grouped_dbscan = [indices_dbscan num_per_index_dbscan];

%exclude outliers
if sum(ismember(indices_dbscan, -1))==1
    grouped_dbscan(1,:)=[];
end
num_per_index_dbscan = grouped_dbscan(:,2);
indices_dbscan = grouped_dbscan(:,1);

%determine the average number of localizations expected for a single site (for all frames)
av_localizations_single_site = set.sample.tb*set.mic.frames/(set.sample.tb+set.sample.td);
%exclude clusters with too little events
grouped_dbscan(num_per_index_dbscan<av_localizations_single_site-rej.cluster_std_factor*sqrt(av_localizations_single_site),:)=[];
num_per_index_dbscan = grouped_dbscan(:,2);
indices_dbscan = grouped_dbscan(:,1);
%check for each localizations if it corresponds to one of the merged clusters
%if not -> outlier -> index 1 (done by building a matrix with all to be rejected values)
data = ana.ROI(i).loc.good;
data(ismember(dbscan_var.idx, indices_dbscan),:)=[];
for j=1:size(ana.ROI(i).SupResParams,2)
    if ismember(ana.ROI(i).SupResParams(j).event_idx,data(:,1))
        ana.ROI(i).SupResParams(j).isRej_DBSCAN=true;
    end
end

if makePlot == 1
    figure
    scatter([ana.ROI(i).SupResParams.x_coord]',[ana.ROI(i).SupResParams.y_coord]', 1, 'r');
    hold on 
    ana.ROI(i).loc.good_x_dbscan_merge = [ana.ROI(i).SupResParams.x_coord]'; %copy
    ana.ROI(i).loc.good_x_dbscan_merge = [ana.ROI(i).loc.good_x_dbscan_merge([ana.ROI(i).SupResParams.isRej_DBSCAN]==0)]; %condition
    ana.ROI(i).loc.good_y_dbscan_merge = [ana.ROI(i).SupResParams.y_coord]';
    ana.ROI(i).loc.good_y_dbscan_merge = [ana.ROI(i).loc.good_y_dbscan_merge([ana.ROI(i).SupResParams.isRej_DBSCAN]==0)]; %condition
    scatter([ana.ROI(i).loc.good_x_dbscan_merge],[ana.ROI(i).loc.good_y_dbscan_merge], 1, 'g');
    hold on
    plot_object_binding_spots(ROIs, set, i)
    xlabel('x-position (pixels)')
    xlim([-(set.ROI.size-1)/4 (set.ROI.size-1)/4])
    ylabel('y-position (pixels)')
    ylim([-(set.ROI.size-1)/4 (set.ROI.size-1)/4])
    box on
    title('DBSCAN merged clusters')
end
end