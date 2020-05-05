function [ana, res] = processing_ROI_mode_2(ana, set, obj, frame_data)

ana = generate_ROI_vector(ana, set);
ana = count_intensity_ROIs_mode_2(ana, frame_data, set);
ana = generate_SNR(ana, set);
ana = generate_cutoff(ana, set);

res = find_if_specific(ana, obj,set);

res = determine_bright_dark_times(res, ana, set);
res = determine_averages_and_binding_spots(ana, res, set);

end