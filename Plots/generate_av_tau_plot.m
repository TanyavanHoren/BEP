function av_tau_plot = generate_av_tau_plot(ana, res)
 figure()
 hold on 
title('Correlation average bright dark time per ROI')
xlabel('average dark time') 
ylabel('average bright time')  
for i=1:ana.ROI.number
    if res.ROI(i).label==1
        av_tau_plot(i)=scatter(res.ROI(i).av_dark_time,res.ROI(i).av_bright_time,'MarkerEdgeColor','g');

    else
        av_tau_plot(i)=scatter(res.ROI(i).av_dark_time,res.ROI(i).av_bright_time,'MarkerEdgeColor','r');
    end
end 
