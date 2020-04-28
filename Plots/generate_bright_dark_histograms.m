function bright_dark_histograms = generate_bright_dark_histograms(intensity_data,ROI_data)

for i=1:ROI_data.number
    figure('Name','Bright Times')
    bright_histogram(i)=histogram(intensity_data.ROI(i).bright_times(:));
    figure('Name','Dark Times')
    dark_histogram(i)= histogram(intensity_data.ROI(i).dark_times(:));
end 