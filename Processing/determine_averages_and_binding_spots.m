function intensity_data = determine_averages_and_binding_spots(ROI_data, intensity_data,experiment_data)

for i=1:ROI_data.number %loop over all ROIs
    intensity_data.ROI(i).average_bright_time=expfit(intensity_data.ROI(i).bright_times(:));
    intensity_data.ROI(i).average_dark_time=expfit(intensity_data.ROI(i).dark_times(:));
    intensity_data.ROI(i).number_bind_calculated=experiment_data.td/intensity_data.ROI(i).average_dark_time;
end