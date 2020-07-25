function Ndet = Nbind_rejection_loop(calibration, makePlot, workspaces, m, Ndet)

Nbind_corr=zeros(1,size(workspaces,2));
Nbind_corr_std=zeros(1,size(workspaces,2));
for i=1:size(workspaces,2)
    S = load(workspaces(i));
    N=zeros(1,size(S.ROIs.ROI,2));
    for l=1:size(S.ROIs.ROI,2) %for each ROI separately, analysis is done
        S.i=l;
        ana = Nbind_rejection(calibration, S, makePlot);
        N(l)=ana.ROI(l).timetrace_data.number_bind_calculated_corr;
    end
    Ndet(m).dataset(i).Nbind_corr = nanmean(N);
    Ndet(m).dataset(i).Nbind_corr_std = nanstd(N);
end
end