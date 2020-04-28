function time_traces = generate_time_traces(ana)

for i=1:ana.ROI.number
    figure()
    time_trace(i)=plot(ana.ROI.ROI(i).timetrace(:)');
    title('Intensity time trace')
    xlabel('Frame number') 
    ylabel('Intensity') 
    ylim([0 inf]);
end 