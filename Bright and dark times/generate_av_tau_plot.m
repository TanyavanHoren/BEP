function av_tau_plot = generate_av_tau_plot(ana, set)
figure()
box('on')
hold on
title('Mapping of the average bright and dark time for each ROI')
xlabel('Average dark time (s)')
ylabel('Average bright time (s)')
for i=1:set.ROI.number
    av_tau_plot(i)=scatter(ana.timetrace_data(i).av_dark_time,ana.timetrace_data(i).av_bright_time,'MarkerEdgeColor','g');
    try
        set(gca,'xscale','log')
        set(gca,'yscale','log')
    end
end
