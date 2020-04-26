function time_traces = generate_time_traces(intensity_data,object_data,analysis_data)

for i=1:object_data.number
    figure()
    time_trace(i)=plot(intensity_data.object(i).timetrace(:)');
    title('Intensity time trace')
    xlabel('Frame number') 
    ylabel('Intensity') 
    ylim([0 inf]);
end 