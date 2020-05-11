function res = determine_averages_and_binding_spots(ana, res, set)

for i=1:ana.ROI.number 
    res.ROI(i).av_bright_time=expfit(res.ROI(i).bright_times(:));
    res.ROI(i).av_dark_time=expfit(res.ROI(i).dark_times(:));
    res.ROI(i).number_bind_calculated=set.sample.td/res.ROI(i).av_dark_time;
end
end