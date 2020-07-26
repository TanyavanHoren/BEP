function Ndet = Nbind_rejection_loop(calibration, makePlot, workspaces, m, Ndet)
%{
Load in datasets. For each dataset, and for each ROI separately, 
    perform clustering using the optimal algorithm (error ellipse, DBSCAN,
    or GMM), and correct for the contributions of non-specific events in 
    the bright and dark time sequences. For each dataset, find the average 
    number of binding sites determined after correction.
    Find the standard deviation as well.

INPUTS
-------
calibration: struct containing the names of the calibration files that 
    should be used
makePlot: do not make plot (if 0), or do make plot (if 1)
workspaces: filenames of the datasets that should be used
m: index of the average binding site number considered (we analyze datasets
    grouped on the average number of binding sites)
Ndet: struct containing the results of binding site quantification 

OUTPUTS 
------
Ndet: struct containing the results of binding site quantification 

Created by Tanya van Horen - July 2020
%}

%%
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