function time_traces = generate_time_traces(ana)

for i=1:ana.ROI.number
    fig = figure('visible','off');
    time_trace(i)=plot(ana.ROI.ROI(i).timetrace(:)');
    title('Intensity time trace')
    xlabel('Frame number (-)') 
    ylabel('Intensity (-)') %in photons
    xlim([0 inf]);
    ylim([0 inf]);
    str = strcat('Figures\ROI_', num2str(i),'_Timetrace.png');
    saveas(fig,str)
end 