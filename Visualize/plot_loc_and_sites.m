function localization_plot = plot_loc_and_sites(SupResParams, set, ROIs, i)

figure
    loc.ROI(i).y=[SupResParams.x_coord]-set.ROI.size/2; %localization assumes other coordinate system
    loc.ROI(i).x=[SupResParams.y_coord]-set.ROI.size/2;
    scatter(loc.ROI(i).x,loc.ROI(i).y,1.5)
    hold on
    loc.ROI(i).x_s=[ROIs.ROI(i).site.position_x]/set.mic.pixelsize;
    loc.ROI(i).y_s=[ROIs.ROI(i).site.position_y]/set.mic.pixelsize;
    scatter(loc.ROI(i).x_s,loc.ROI(i).y_s,25, 'r','x')
    hold on
end