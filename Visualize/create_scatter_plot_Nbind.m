function scatter_plot_Nbind = create_scatter_plot_Nbind(workspaces, Ndet_binding_spots, Ndet_freq_ratio, m, Ndet, plotcolours)

N_determined=zeros(1,size(workspaces,2));
N_determined_std=zeros(1,size(workspaces,2));
for i=1:size(workspaces,2) %loop over different ratios
    S = load(workspaces(i)); %contains a specified number of ROIs
    N=zeros(1,size(S.ROIs.ROI,2));
    for l=1:size(S.ROIs.ROI,2) %for each ROI separately, analysis is done
        N(l)=S.ana.ROI(l).timetrace_data.number_bind_calculated;
    end
    N_determined(i)=nanmean(N);
    N_determined_std(i)=nanstd(N);
end
if m==1
    figure
end
errorbar(N_determined,Ndet_freq_ratio,N_determined_std,'horizontal','-o','Color',plotcolours(m,:),'MarkerEdgeColor',plotcolours(m,:),'MarkerFaceColor',plotcolours(m,:))
hold on 
errorbar([Ndet(m).dataset.Nbind_corr],Ndet_freq_ratio,[Ndet(m).dataset.Nbind_corr_std],'horizontal','-*','Color',plotcolours(m,:),'MarkerEdgeColor',plotcolours(m,:),'MarkerFaceColor',plotcolours(m,:))
hold on
plot(ones(1,size(Ndet_freq_ratio,2))*Ndet_binding_spots(m),Ndet_freq_ratio,':','Linewidth',1,'Color',plotcolours(m,:),'MarkerSize',10,'MarkerEdgeColor',plotcolours(m,:),'MarkerFaceColor',plotcolours(m,:))
hold on
set(gca, 'XScale', 'log')
xlim([0 inf]);
ylim([Ndet_freq_ratio(1) inf]);
xlabel('Number of determined binding sites')
ylabel('Ratio specific to non-specific')
box on
title('Improvement binding site quantification')
if m==size(Ndet_binding_spots,2)
    legend([num2str(Ndet_binding_spots(1)) ' sites, pre-correction'],[num2str(Ndet_binding_spots(1)) ' sites, post-correction'],[num2str(Ndet_binding_spots(1)) ' sites, input value'],[num2str(Ndet_binding_spots(2)) ' sites, pre-correction'],[num2str(Ndet_binding_spots(2)) ' sites, post-correction'],[num2str(Ndet_binding_spots(2)) ' sites, input value'],[num2str(Ndet_binding_spots(3)) ' sites, pre-correction'],[num2str(Ndet_binding_spots(3)) ' sites, post-correction'],[num2str(Ndet_binding_spots(3)) ' sites, input value'],[num2str(Ndet_binding_spots(4)) ' sites, pre-correction'],[num2str(Ndet_binding_spots(4)) ' sites, post-correction'],[num2str(Ndet_binding_spots(4)) ' sites, input value'])
end
end
