function av_tau_plot = generate_av_tau_plot(ana, res)
 figure()
 box('on')
 hold on 
title('Mapping of the average bright and dark time for each ROI')
xlabel('Average dark time (s)') 
ylabel('Average bright time (s)')  
for i=1:ana.ROI.number
    if res.ROI(i).label==1
        av_tau_plot(i)=scatter(res.ROI(i).av_dark_time,res.ROI(i).av_bright_time,'MarkerEdgeColor','g');
        set(gca,'xscale','log')
        set(gca,'yscale','log')
        %if specific green, if non-specific red
    else
        av_tau_plot(i)=scatter(res.ROI(i).av_dark_time,res.ROI(i).av_bright_time,'MarkerEdgeColor','r');
        set(gca,'xscale','log')
        set(gca,'yscale','log')
    end
end 
