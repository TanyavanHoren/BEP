function ana = reject_outside_ellipse(ana,i, set, ROIs, makePlot, k)

if k==3
    %good = use for error ellipse fitting
    ana.ROI(i).loc.good_frame = [ana.ROI(i).SupResParams.frame_idx]'; %copy
    ana.ROI(i).loc.good_frame = [ana.ROI(i).loc.good_frame([ana.ROI(i).SupResParams.isRej_DBSCAN2]==0)]; %condition
    ana.ROI(i).loc.good_x = [ana.ROI(i).SupResParams.x_coord]'; %copy
    ana.ROI(i).loc.good_x = [ana.ROI(i).loc.good_x([ana.ROI(i).SupResParams.isRej_DBSCAN2]==0)]; %condition
    ana.ROI(i).loc.good_y = [ana.ROI(i).SupResParams.y_coord]';
    ana.ROI(i).loc.good_y = [ana.ROI(i).loc.good_y([ana.ROI(i).SupResParams.isRej_DBSCAN2]==0)];
    ana.ROI(i).loc.good = [ana.ROI(i).loc.good_frame ana.ROI(i).loc.good_x ana.ROI(i).loc.good_y];
elseif k==5
    %good = use for error ellipse fitting
    ana.ROI(i).loc.good_frame = [ana.ROI(i).SupResParams.frame_idx]'; %copy
    ana.ROI(i).loc.good_frame = [ana.ROI(i).loc.good_frame([ana.ROI(i).SupResParams.isRej_GMM2]==0)]; %condition
    ana.ROI(i).loc.good_x = [ana.ROI(i).SupResParams.x_coord]'; %copy
    ana.ROI(i).loc.good_x = [ana.ROI(i).loc.good_x([ana.ROI(i).SupResParams.isRej_GMM2]==0)]; %condition
    ana.ROI(i).loc.good_y = [ana.ROI(i).SupResParams.y_coord]';
    ana.ROI(i).loc.good_y = [ana.ROI(i).loc.good_y([ana.ROI(i).SupResParams.isRej_GMM2]==0)];
    ana.ROI(i).loc.good = [ana.ROI(i).loc.good_frame ana.ROI(i).loc.good_x ana.ROI(i).loc.good_y];
end

%fit error ellipse to specified points
[~,r_ellipse] = error_elipse(ana, i);
%make list with points outside the ellipse
data = [[ana.ROI(i).SupResParams.frame_idx]' abs(inhull([[ana.ROI(i).SupResParams.x_coord]' [ana.ROI(i).SupResParams.y_coord]'], r_ellipse)-1)*2']; %check if positions in ellipse
data(data(:,2) ~= 2,:)=[]; %make a list of all points outside of the ellipse 
logical = num2cell(false(1,length(ana.ROI(i).SupResParams))); %reset; we only want to judge based on error ellipse
if k==1
    [ana.ROI(i).SupResParams.isRej_DEFAULT]=logical{:};
elseif k==3
    [ana.ROI(i).SupResParams.isRej_DBSCAN2]=logical{:}; 
elseif k==5
    [ana.ROI(i).SupResParams.isRej_GMM2]=logical{:}; 
end

%change isRej values 
for j=1:size(ana.ROI(i).SupResParams,2)
    if ismember(ana.ROI(i).SupResParams(j).frame_idx,data(:,1))
        if k==1
            ana.ROI(i).SupResParams(j).isRej_DEFAULT=2;
        elseif k==3
            ana.ROI(i).SupResParams(j).isRej_DBSCAN2=2;
        elseif k==5
            ana.ROI(i).SupResParams(j).isRej_GMM2=2;
        end
    end
end

if makePlot == 1
    visualize_rejection_ellipse(ana,i, set, ROIs, r_ellipse, k);
end
end