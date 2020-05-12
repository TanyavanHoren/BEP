function bright_dark_histograms = generate_bright_dark_histograms(ana, set)

parfor i=1:set.ROI.number
fig = figure('Name','Bright Times', 'visible','off');
bright_histogram(i)=histogram(ana.timetrace_data(i).ontime(:),20);
xlabel('Bright time (s)')
ylabel('Occurance (-)')
xlim([0 inf]);
ylim([0 inf]);
legend('Occurance')
str = strcat('Figures\ROI_', num2str(i), '_Bright_histogram.png');
saveas(fig,str)

fig = figure('Name','Dark Times','visible','off');
dark_histogram(i)= histogram(ana.timetrace_data(i).offtime(:),20);
xlabel('Dark time (s)')
ylabel('Occurance (-)')
xlim([0 inf]);
ylim([0 inf]);
legend('Occurance')
str = strcat('Figures\ROI_', num2str(i), '_Dark_histogram.png');
saveas(fig,str)
end
end