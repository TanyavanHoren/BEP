function bright_dark_histograms = generate_bright_dark_histograms(intensity_data,object_data)

for i=1:object_data.number
    figure('Name','Bright Times')
    bright_histogram(i)=histogram(intensity_data.object(i).bright_times(:));
    figure('Name','Dark Times')
    dark_histogram(i)= histogram(intensity_data.object(i).dark_times(:));
end 