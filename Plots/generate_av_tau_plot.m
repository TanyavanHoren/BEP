function av_tau_plot = generate_av_tau_plot(ana, res)
 figure()
 hold on 
for i=1:ana.ROI.number
    av_tau_plot(i)=scatter(res.ROI(i).av_dark_time,res.ROI(i).av_bright_time);
    title('Correlation average bright dark time per ROI')
    xlabel('average dark time') 
    ylabel('average bright time')  
end 