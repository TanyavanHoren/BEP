function time_traces = generate_time_traces(time_trace_data, set, params)

for i=1:set.ROI.number
    %full timetrace
    figure
    plot([set.mic.dt:set.mic.dt:set.mic.t_end],time_trace_data.ROI(i).frame(:)');
    yline(params.threshold, 'r--');
    title('Intensity time trace')
    xlabel('Time (s)') 
    ylabel('Intensity (-)') %in photons
    xlim([0 inf]);
    ylim([set.bg.mu*0.9*set.ROI.size^2 inf]);
    %short segment
    figure
    plot([set.mic.dt*4400:set.mic.dt:set.mic.dt*5000],time_trace_data.ROI(i).frame(4400:5000)');
    yline(params.threshold, 'r--');
    title('Intensity time trace')
    xlabel('Time (s)') 
    ylabel('Intensity (-)') %in photons
    xlim([set.mic.dt*4400 set.mic.dt*5000]);
    ylim([set.bg.mu*0.9*set.ROI.size^2 inf]);
end 