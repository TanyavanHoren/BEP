function ana = position_correction(ana, set, i)
%{
Shift the x and y coordinates of the localizations, such that the
origin is at the ROI center. 

INPUTS
-------
ana: struct containing the results from analysis 
set: system settings
i: index of considered ROI

OUTPUTS 
------
ana: struct containing the results from analysis 
(with shifted localizations)

Created by Tanya van Horen - July 2020
%}

%%
temp_y=num2cell([ana.ROI(i).SupResParams.x_coord]-set.ROI.size/2); %localization assumes other coordinate system
temp_x=num2cell([ana.ROI(i).SupResParams.y_coord]-set.ROI.size/2);
[ana.ROI(i).SupResParams.x_coord] = temp_x{:};
[ana.ROI(i).SupResParams.y_coord] = temp_y{:};

figure
scatter([ana.ROI(i).SupResParams.x_coord], [ana.ROI(i).SupResParams.y_coord],1);
xlabel('x-position (pixels)')
ylabel('y-position (pixels)')
xlim([-set.ROI.size/2 set.ROI.size/2])
ylim([([-set.ROI.size/2 set.ROI.size/2])])
box on
title('Event localizations')
end