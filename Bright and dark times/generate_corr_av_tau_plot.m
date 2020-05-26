function av_tau_plot = generate_corr_av_tau_plot(ana, set)
figure()
box('on')
hold on
title('Mapping of the average bright and dark time for each ROI (Corrected)')
xlabel('Average dark time (s)')
ylabel('Average bright time (s)')
for i=1:set.ROI.number
    av_tau_plot(i)=scatter(ana.ROI(i).timetrace_data.av_dark_time_corr,ana.ROI(i).timetrace_data.av_bright_time_corr,'MarkerEdgeColor','g');
    try
        set(gca,'xscale','log')
        set(gca,'yscale','log')
    end
end
