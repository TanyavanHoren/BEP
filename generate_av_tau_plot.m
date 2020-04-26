function av_tau_plot = generate_av_tau_plot(intensity_data,object_data)
 figure()
 hold on 
for i=1:object_data.number
   
    av_tau_plot(i)=scatter(intensity_data.object(i).average_dark_time,intensity_data.object(i).average_bright_time);
    title('Correlation average bright dark time per ROI')
    xlabel('average dark time') 
    ylabel('average bright time') 
    
end 