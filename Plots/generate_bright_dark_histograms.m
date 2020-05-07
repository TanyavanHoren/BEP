function bright_dark_histograms = generate_bright_dark_histograms(res, ana)

parfor i=1:ana.ROI.number
    fig = figure('Name','Bright Times', 'visible','off');
    bright_histogram(i)=histogram(res.ROI(i).bright_times(:),20);
    xlabel('Bright time (s)') 
    ylabel('Occurance (-)') 
    xlim([0 inf]);
    ylim([0 inf]);
    legend('Occurance')
    str = strcat('Figures\ROI_', num2str(i), '_Bright_histogram.png');
    saveas(fig,str)
    
    fig = figure('Name','Dark Times','visible','off');
    dark_histogram(i)= histogram(res.ROI(i).dark_times(:),20);
    xlabel('Dark time (s)') 
    ylabel('Occurance (-)') 
    xlim([0 inf]);
    ylim([0 inf]);
    legend('Occurance')
    str = strcat('Figures\ROI_', num2str(i), '_Dark_histogram.png');
    saveas(fig,str)
end 