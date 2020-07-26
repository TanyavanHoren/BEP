function minima = Optimize_dbscan_loop(workspaces, minPts, eps)
%{
Find the optimal DBSCAN parameters (eps and minPts) for each of the 
    datasets. This is done by finding the eps and minPts values at which
    the number of false assignments is minimal (averaged across all ROIs).
    A heatmap is plotted for each dataset, showing the change in the 
    amount of false assignments as a function of eps and minPts. 

INPUTS
-------
workspaces: filenames of the datasets that will be investigated
minPts: minPts values that are used in the iterative process
eps: eps values that are used in the iterative process

OUTPUTS 
------
minima: for each dataset, the optimal eps and minPts value, and the 
    corresponding average amount of false positives

Created by Tanya van Horen - July 2020
%}

%% Find number of false positives/negatives for each combination of minPts and EPS
for i=1:size(workspaces,2)
    S = load(workspaces(i));
    for l=1:size(S.ROIs.ROI,2) %for each ROI separately, analysis is done
        S.i=l;
        false_pos.dataset(i).ROI(l).dbscan=[];
        false_neg.dataset(i).ROI(l).dbscan=[];
        for m=1:size(eps,2) %rows are determined by y-variable
            for n=1:size(minPts,2) %columns are determined by x-variable
                S.rej.dbscan_minPts=minPts(n);
                S.rej.dbscan_eps=eps(m);
                % Determine false positives and negatives
                checks.dataset(i).ROI(l).check = Optimize_dbscan_param(S,0);
                % Delete empty row corresponding to k=1
                checks.dataset(i).ROI(l).check( all( cell2mat( arrayfun( @(x) structfun( @isempty, x ), checks.dataset(i).ROI(l).check, 'UniformOutput', false ) ), 1 ) ) = [];
                % Put information in struct
                false_pos.dataset(i).ROI(l).dbscan(m,n)=checks.dataset(i).ROI(l).check.false_pos;
                false_neg.dataset(i).ROI(l).dbscan(m,n)=checks.dataset(i).ROI(l).check.false_neg;
                false_tot.dataset(i).ROI(l).dbscan(m,n)=(checks.dataset(i).ROI(l).check.false_pos+checks.dataset(i).ROI(l).check.false_neg);
            end
        end
    end
end

%% Plot results in heatmap
for i=1:size(workspaces,2)
    false_pos.dataset(i).av=zeros(size(eps,2),size(minPts,2));
    false_neg.dataset(i).av=zeros(size(eps,2),size(minPts,2));
    false_tot.dataset(i).av=zeros(size(eps,2),size(minPts,2));
    for l=1:size(S.ROIs.ROI,2)
        false_pos.dataset(i).av=false_pos.dataset(i).av+false_pos.dataset(i).ROI(l).dbscan;
        false_neg.dataset(i).av=false_neg.dataset(i).av+false_neg.dataset(i).ROI(l).dbscan;
        false_tot.dataset(i).av=false_tot.dataset(i).av+false_tot.dataset(i).ROI(l).dbscan;
    end %average over ROIs:
    false_pos.dataset(i).av=false_pos.dataset(i).av./size(S.ROIs.ROI,2);
    false_neg.dataset(i).av=false_neg.dataset(i).av./size(S.ROIs.ROI,2);
    false_tot.dataset(i).av=false_tot.dataset(i).av./size(S.ROIs.ROI,2);
    
    figure
    hm=heatmap(minPts,eps,false_tot.dataset(i).av,'ColorScaling','log','Colormap',parula,'CellLabelColor','none','GridVisible','off');
    title('DBSCAN optimization')
    xlabel('minPts')
    ylabel('eps')
end

%% Find minimum per dataset 
for i=1:size(workspaces,2)
    [min_val,idx]=min(false_tot.dataset(i).av(:));
    [row,col]=ind2sub(size(false_tot.dataset(i).av),idx);
    minima.dataset(i).av_minimum_eps=eps(row);
    minima.dataset(i).av_minimum_minPts=minPts(col);
    minima.dataset(i).av_minimum_val=min_val;
end
end