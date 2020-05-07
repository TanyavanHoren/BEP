function time_traces = generate_time_traces(ana, set)

parfor i=1:ana.ROI.number
    fig = figure('visible','off');
    plot([set.mic.dt:set.mic.dt:set.mic.t_end],ana.ROI.ROI(i).timetrace(:)');
    title('Intensity time trace')
    xlabel('Time (s)') 
    ylabel('Intensity (-)') %in photons
    xlim([0 inf]);
    ylim([0 inf]);
    str = strcat('Figures\ROI_', num2str(i),'_Timetrace.png');
    saveas(fig,str)
end 