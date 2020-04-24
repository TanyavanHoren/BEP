function time_traces = generate_time_traces(intensity_data,nanorod_data,analysis_data)

for i=1:nanorod_data.number
    figure(i)
    time_trace(i)=plot(intensity_data.nanorod(i,1:analysis_data.frames+1)');
    title('Intensity time trace')
    xlabel('Frame number') 
    ylabel('Intensity') 
end 