function ana = determine_averages_and_binding_spots(ana, set)

for i=1:set.ROI.number
ana.timetrace_data(i).av_bright_time=expfit(ana.timetrace_data(i).ontime(:));
ana.timetrace_data(i).av_dark_time=expfit(ana.timetrace_data(i).offtime(:));
ana.timetrace_data(i).number_bind_calculated=set.sample.td/ana.timetrace_data(i).av_dark_time;
end
end