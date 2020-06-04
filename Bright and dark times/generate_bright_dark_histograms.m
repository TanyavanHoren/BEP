function bright_dark_histograms = generate_bright_dark_histograms(ana, set)

for i=1:set.ROI.number
fig = figure('Name','Bright Times', 'visible','off','Color', 'w');
bright_histogram(i)=histogram(ana.ROI(i).timetrace_data.ontime(:),20);
xlabel('Bright time (s)')
ylabel('Occurance (-)')
xlim([0 inf]);
ylim([0 inf]);
legend('Occurance')
str = strcat('Figures\ROI_', num2str(i), '_Bright_histogram.png');
export_fig(str)

fig = figure('Name','Dark Times','visible','off','Color', 'w');
dark_histogram(i)= histogram(ana.ROI(i).timetrace_data.offtime(:),20);
xlabel('Dark time (s)')
ylabel('Occurance (-)')
xlim([0 inf]);
ylim([0 inf]);
legend('Occurance')
str = strcat('Figures\ROI_', num2str(i), '_Dark_histogram.png');
export_fig(str)
end
end