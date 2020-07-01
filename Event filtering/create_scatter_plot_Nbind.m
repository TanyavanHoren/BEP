function scatter_plot_Nbind = create_scatter_plot_Nbind(workspaces, Ndet_binding_spots, Ndet_freq_ratio, m, Ndet, plotcolours)

N=zeros(1,size(workspaces,2));
N_determined=zeros(1,size(workspaces,2));
for i=1:size(workspaces,2) %loop over different ratios
    S = load(workspaces(i)); %contains a specified number of ROIs
    for l=1:size(S.ROIs.ROI,2) %for each ROI separately, analysis is done
        N(i)=N(i)+S.ana.ROI(l).timetrace_data.number_bind_calculated;
    end
    N_determined(i)=N(i)/size(S.ROIs.ROI,2);
end
if m==1
    figure
end
plot(N_determined,Ndet_freq_ratio,strcat(plotcolours{m},'-o'))
hold on
plot([Ndet(m).dataset.Nbind_corr],Ndet_freq_ratio,strcat(plotcolours{m},'-+'))
hold on 
plot(ones(1,size(Ndet_freq_ratio,2))*Ndet_binding_spots(m),Ndet_freq_ratio,strcat(plotcolours{m},'-*'))
hold on
xlim([0 inf]);
set(gca, 'XScale', 'log')
ylim([Ndet_freq_ratio(1) inf]);
xlabel('Number of determined binding sites')
ylabel('Ratio specific to non-specific')
box on
title('Number of determined binding sites')
if m==size(Ndet_binding_spots,2)
    legend([num2str(Ndet_binding_spots(1)) ' sites, pre-correction'],[num2str(Ndet_binding_spots(1)) ' sites, post-correction'],[num2str(Ndet_binding_spots(1)) ' sites, input value'],[num2str(Ndet_binding_spots(2)) ' sites, pre-correction'],[num2str(Ndet_binding_spots(2)) ' sites, post-correction'],[num2str(Ndet_binding_spots(2)) ' sites, input value'],[num2str(Ndet_binding_spots(3)) ' sites, pre-correction'],[num2str(Ndet_binding_spots(3)) ' sites, post-correction'],[num2str(Ndet_binding_spots(3)) ' sites, input value'])
end
end
