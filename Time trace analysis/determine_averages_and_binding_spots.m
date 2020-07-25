function ana = determine_averages_and_binding_spots(ana, set)

for i=1:set.ROI.number
ana.ROI(i).timetrace_data.av_bright_time=expfit(ana.ROI(i).timetrace_data.ontime(:));
ana.ROI(i).timetrace_data.av_dark_time=expfit(ana.ROI(i).timetrace_data.offtime(:));
ana.ROI(i).timetrace_data.number_bind_calculated=set.sample.td/ana.ROI(i).timetrace_data.av_dark_time;
end
end