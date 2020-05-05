function [ana, res] = processing_ROI_mode_other(ana, set, obj)

ana = generate_SNR(ana, set);
ana = generate_cutoff(ana, set);

if set.other.ROI_mode ~= 3
    res = find_if_specific(ana, obj,set);
else
    res = [];
end
res = determine_bright_dark_times(res, ana, set);
res = determine_averages_and_binding_spots(ana, res, set);

end