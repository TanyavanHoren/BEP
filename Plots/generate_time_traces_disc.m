function void = generate_time_traces_disc(ana)

for i=1:ana.ROI.number
    fig = figure('visible','off');
    plot(ana.ROI.ROI(i).timetrace_disc(:)');
    title('Discretized intensity time trace')
    xlabel('Frame number (-)') 
    ylabel('Bound (1) or unbound (0)') 
    xlim([0 inf]);
    ylim([0 inf]);
    str = strcat('Figures\ROI_', num2str(i), '_Timetrace_disc.png');
    saveas(fig,str)
end 