function void = generate_time_traces_disc(ana, set)

parfor i=1:ana.ROI.number
    fig = figure('visible','off');
    plot([set.mic.dt:set.mic.dt:set.mic.t_end],ana.ROI.ROI(i).timetrace_disc(:)');
    title('Discretized intensity time trace')
    xlabel('Time (s)') 
    ylabel('Bound (1) or unbound (0)') 
    xlim([0 inf]);
    ylim([0 inf]);
    str = strcat('Figures\ROI_', num2str(i), '_Timetrace_disc.png');
    saveas(fig,str)
end 