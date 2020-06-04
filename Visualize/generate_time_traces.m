function time_traces = generate_time_traces(time_trace_data, set)

for i=1:set.ROI.number
    fig = figure('visible','off');
    plot([set.mic.dt:set.mic.dt:set.mic.t_end],time_trace_data.ROI(i).frame(:)');
    title('Intensity time trace')
    xlabel('Time (s)') 
    ylabel('Intensity (-)') %in photons
    xlim([0 inf]);
    ylim([set.bg.mu*0.9*set.ROI.size^2 inf]);
    str = strcat('Figures\ROI_', num2str(i),'_Timetrace.png');
    saveas(fig,str)
end 