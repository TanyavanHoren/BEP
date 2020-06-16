function scatter_plot_Nbind = create_scatter_plot_Nbind(workspaces, Ndet_binding_spots, Ndet_freq_ratio, m)

for i=1:size(workspaces,2) %loop over different ratios
    S = load(workspaces(i)); %contains a specified number of ROIs
    N(i)=0;
    for l=1:size(S.ROIs.ROI,2) %for each ROI separately, analysis is done
        N(i)=N(i)+S.ana.ROI(l).timetrace_data.number_bind_calculated;
    end
    N_determined(i)=N(i)/size(S.ROIs.ROI,2);
end
scatter(N_determined,Ndet_freq_ratio,10)
xlim([0 inf]);
ylim([0 inf]);
xlabel('Number of determined binding sites')
ylabel('Ratio specific to non-specific')
box on
title('Number of determined binding sites pre-correction')
if m==size(Ndet_binding_spots,2)
    legend([num2str(Ndet_binding_spots(1)) ' binding spots'],[num2str(Ndet_binding_spots(2)) ' binding spots'],[num2str(Ndet_binding_spots(3)) ' binding spots'])
end
hold on
end
