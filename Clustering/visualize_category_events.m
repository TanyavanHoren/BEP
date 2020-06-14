function visualization_category_events = visualize_category_events(ana,i, set, ROIs)

%category 0
<<<<<<< HEAD
ana.ROI(i).loc.cat0_frame = [ana.ROI(i).SupResParams.frame_idx]'; %copy
ana.ROI(i).loc.cat0_frame = [ana.ROI(i).loc.cat0_frame([ana.ROI(i).SupResParams.isNonSpecific]==0)]; %condition
=======
ana.ROI(i).loc.cat0_index = [ana.ROI(i).SupResParams.event_idx]'; %copy
ana.ROI(i).loc.cat0_index = [ana.ROI(i).loc.cat0_index([ana.ROI(i).SupResParams.isNonSpecific]==0)]; %condition
>>>>>>> Merged-ROIs
ana.ROI(i).loc.cat0_x = [ana.ROI(i).SupResParams.x_coord]'; %copy
ana.ROI(i).loc.cat0_x = [ana.ROI(i).loc.cat0_x([ana.ROI(i).SupResParams.isNonSpecific]==0)]; %condition
ana.ROI(i).loc.cat0_y = [ana.ROI(i).SupResParams.y_coord]';
ana.ROI(i).loc.cat0_y = [ana.ROI(i).loc.cat0_y([ana.ROI(i).SupResParams.isNonSpecific]==0)];
<<<<<<< HEAD
ana.ROI(i).loc.cat0 = [ana.ROI(i).loc.cat0_frame ana.ROI(i).loc.cat0_x ana.ROI(i).loc.cat0_y];
%category 1
ana.ROI(i).loc.cat1_frame = [ana.ROI(i).SupResParams.frame_idx]'; %copy
ana.ROI(i).loc.cat1_frame = [ana.ROI(i).loc.cat1_frame([ana.ROI(i).SupResParams.isNonSpecific]==1)]; %condition
=======
ana.ROI(i).loc.cat0 = [ana.ROI(i).loc.cat0_index ana.ROI(i).loc.cat0_x ana.ROI(i).loc.cat0_y];
%category 1
ana.ROI(i).loc.cat1_index = [ana.ROI(i).SupResParams.event_idx]'; %copy
ana.ROI(i).loc.cat1_index = [ana.ROI(i).loc.cat1_index([ana.ROI(i).SupResParams.isNonSpecific]==1)]; %condition
>>>>>>> Merged-ROIs
ana.ROI(i).loc.cat1_x = [ana.ROI(i).SupResParams.x_coord]'; %copy
ana.ROI(i).loc.cat1_x = [ana.ROI(i).loc.cat1_x([ana.ROI(i).SupResParams.isNonSpecific]==1)]; %condition
ana.ROI(i).loc.cat1_y = [ana.ROI(i).SupResParams.y_coord]';
ana.ROI(i).loc.cat1_y = [ana.ROI(i).loc.cat1_y([ana.ROI(i).SupResParams.isNonSpecific]==1)];
<<<<<<< HEAD
ana.ROI(i).loc.cat1 = [ana.ROI(i).loc.cat1_frame ana.ROI(i).loc.cat1_x ana.ROI(i).loc.cat1_y];
% category 2
ana.ROI(i).loc.cat2_frame = [ana.ROI(i).SupResParams.frame_idx]'; %copy
ana.ROI(i).loc.cat2_frame = [ana.ROI(i).loc.cat2_frame([ana.ROI(i).SupResParams.isNonSpecific]==2)]; %condition
=======
ana.ROI(i).loc.cat1 = [ana.ROI(i).loc.cat1_index ana.ROI(i).loc.cat1_x ana.ROI(i).loc.cat1_y];
% category 2
ana.ROI(i).loc.cat2_index = [ana.ROI(i).SupResParams.event_idx]'; %copy
ana.ROI(i).loc.cat2_index = [ana.ROI(i).loc.cat2_index([ana.ROI(i).SupResParams.isNonSpecific]==2)]; %condition
>>>>>>> Merged-ROIs
ana.ROI(i).loc.cat2_x = [ana.ROI(i).SupResParams.x_coord]'; %copy
ana.ROI(i).loc.cat2_x = [ana.ROI(i).loc.cat2_x([ana.ROI(i).SupResParams.isNonSpecific]==2)]; %condition
ana.ROI(i).loc.cat2_y = [ana.ROI(i).SupResParams.y_coord]';
ana.ROI(i).loc.cat2_y = [ana.ROI(i).loc.cat2_y([ana.ROI(i).SupResParams.isNonSpecific]==2)];
<<<<<<< HEAD
ana.ROI(i).loc.cat2 = [ana.ROI(i).loc.cat2_frame ana.ROI(i).loc.cat2_x ana.ROI(i).loc.cat2_y];
% category 3
ana.ROI(i).loc.cat3_frame = [ana.ROI(i).SupResParams.frame_idx]'; %copy
ana.ROI(i).loc.cat3_frame = [ana.ROI(i).loc.cat3_frame([ana.ROI(i).SupResParams.isNonSpecific]==3)]; %condition
=======
ana.ROI(i).loc.cat2 = [ana.ROI(i).loc.cat2_index ana.ROI(i).loc.cat2_x ana.ROI(i).loc.cat2_y];
% category 3
ana.ROI(i).loc.cat3_index = [ana.ROI(i).SupResParams.event_idx]'; %copy
ana.ROI(i).loc.cat3_index = [ana.ROI(i).loc.cat3_index([ana.ROI(i).SupResParams.isNonSpecific]==3)]; %condition
>>>>>>> Merged-ROIs
ana.ROI(i).loc.cat3_x = [ana.ROI(i).SupResParams.x_coord]'; %copy
ana.ROI(i).loc.cat3_x = [ana.ROI(i).loc.cat3_x([ana.ROI(i).SupResParams.isNonSpecific]==3)]; %condition
ana.ROI(i).loc.cat3_y = [ana.ROI(i).SupResParams.y_coord]';
ana.ROI(i).loc.cat3_y = [ana.ROI(i).loc.cat3_y([ana.ROI(i).SupResParams.isNonSpecific]==3)];
<<<<<<< HEAD
ana.ROI(i).loc.cat3 = [ana.ROI(i).loc.cat3_frame ana.ROI(i).loc.cat3_x ana.ROI(i).loc.cat3_y];
=======
ana.ROI(i).loc.cat3 = [ana.ROI(i).loc.cat3_index ana.ROI(i).loc.cat3_x ana.ROI(i).loc.cat3_y];
>>>>>>> Merged-ROIs

figure
scatter([ana.ROI(i).loc.cat0_x],[ana.ROI(i).loc.cat0_y], 1, 'g'); %specific
hold on 
scatter([ana.ROI(i).loc.cat1_x],[ana.ROI(i).loc.cat1_y], 1, 'r'); %non-specific
hold on
scatter([ana.ROI(i).loc.cat2_x],[ana.ROI(i).loc.cat2_y], 1, 'b'); %both
hold on
scatter([ana.ROI(i).loc.cat3_x],[ana.ROI(i).loc.cat3_y], 1, 'y'); %neither
%draw actual particle shape
hold on 
plot_object_binding_spots(ROIs, set, i);
xlabel('x-position (pixels)')
ylabel('y-position (pixels)')
xlim([-set.ROI.size/2 set.ROI.size/2])
ylim([([-set.ROI.size/2 set.ROI.size/2])])
box on
title('True categories')
end
