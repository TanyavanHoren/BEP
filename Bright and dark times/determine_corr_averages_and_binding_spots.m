function ana = determine_corr_averages_and_binding_spots(ana, set, i)

ana.ROI(i).timetrace_data.av_bright_time_corr=expfit(ana.ROI(i).timetrace_data.ontime_corr(:));
ana.ROI(i).timetrace_data.av_dark_time_corr=expfit(ana.ROI(i).timetrace_data.offtime_corr(:));
ana.ROI(i).timetrace_data.number_bind_calculated_corr=set.sample.td/ana.ROI(i).timetrace_data.av_dark_time_corr;
end