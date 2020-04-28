function time_traces = generate_time_traces_disc(intensity_data,ROI_data)

for i=1:ROI_data.number
    figure()
    time_trace(i)=plot(intensity_data.ROI(i).timetrace_disc(:)');
    title('Intensity time trace')
    xlabel('Frame number') 
    ylabel('Intensity') 
    ylim([0 inf]);
end 