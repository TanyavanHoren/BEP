function intensity_data = determine_averages_and_binding_spots(object_data, intensity_data,experiment_data)

for i=1:object_data.number %loop over all objects
    intensity_data.object(i).average_bright_time=expfit(intensity_data.object(i).bright_times(:));
    intensity_data.object(i).average_dark_time=expfit(intensity_data.object(i).dark_times(:));
    intensity_data.object(i).number_bind_calculated=experiment_data.td/intensity_data.object(i).average_dark_time;
end