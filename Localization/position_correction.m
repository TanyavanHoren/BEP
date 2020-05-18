function ana = position_correction(ana, set, i)

temp_y=num2cell([ana.ROI(i).SupResParams.x_coord]-set.ROI.size/2); %localization assumes other coordinate system
temp_x=num2cell([ana.ROI(i).SupResParams.y_coord]-set.ROI.size/2);
[ana.ROI(i).SupResParams.x_coord] = temp_x{:};
[ana.ROI(i).SupResParams.y_coord] = temp_y{:};
end