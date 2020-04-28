function bright_dark_histograms = generate_bright_dark_histograms(res, ana)

for i=1:ana.ROI.number
    figure('Name','Bright Times')
    bright_histogram(i)=histogram(res.ROI(i).bright_times(:));
    figure('Name','Dark Times')
    dark_histogram(i)= histogram(res.ROI(i).dark_times(:));
end 