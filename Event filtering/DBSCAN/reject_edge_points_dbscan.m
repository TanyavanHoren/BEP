function ana = reject_edge_points_dbscan(ana, i, rej)

radial_distance = sqrt([ana.ROI(i).SupResParams.x_coord].^2+[ana.ROI(i).SupResParams.y_coord].^2);
ana.edge_points.logical = radial_distance>ones(1,length(ana.ROI(i).SupResParams)).*rej.edge_point_distance;
%'non_edge' is anything not edge point -> these points can be used for further analysis
ana.ROI(i).loc.non_edge_event = [ana.ROI(i).SupResParams.event_idx]'; %copy
ana.ROI(i).loc.non_edge_event = [ana.ROI(i).loc.non_edge_event(ana.edge_points.logical==0)]; %condition
ana.ROI(i).loc.non_edge_x = [ana.ROI(i).SupResParams.x_coord]'; %copy
ana.ROI(i).loc.non_edge_x = [ana.ROI(i).loc.non_edge_x(ana.edge_points.logical==0)]; %condition
ana.ROI(i).loc.non_edge_y = [ana.ROI(i).SupResParams.y_coord]';
ana.ROI(i).loc.non_edge_y = [ana.ROI(i).loc.non_edge_y(ana.edge_points.logical==0)];
ana.ROI(i).loc.non_edge = [ana.ROI(i).loc.non_edge_event ana.ROI(i).loc.non_edge_x ana.ROI(i).loc.non_edge_y];
ana.edge_points.logical = num2cell(ana.edge_points.logical);
end