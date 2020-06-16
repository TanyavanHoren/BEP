function [false_pos, false_neg, false_av, minima] = Optimize_dbscan_loop(workspaces, minPts, eps)

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
                % Determine false/true positives/negatives
                checks.dataset(i).ROI(l).check = Optimize_dbscan_param(S,0);
                % Delete empty row corresponding to k=1
                checks.dataset(i).ROI(l).check( all( cell2mat( arrayfun( @(x) structfun( @isempty, x ), checks.dataset(i).ROI(l).check, 'UniformOutput', false ) ), 1 ) ) = [];
                false_pos.dataset(i).ROI(l).dbscan(m,n)=checks.dataset(i).ROI(l).check.false_pos;
                false_neg.dataset(i).ROI(l).dbscan(m,n)=checks.dataset(i).ROI(l).check.false_neg;
                false_av.dataset(i).ROI(l).dbscan(m,n)=(checks.dataset(i).ROI(l).check.false_pos+checks.dataset(i).ROI(l).check.false_neg)/2;
            end
        end
    end
end

%% Plot results in surface plot
for i=1:size(workspaces,2)
    false_pos.dataset(i).av=zeros(size(eps,2),size(minPts,2));
    false_neg.dataset(i).av=zeros(size(eps,2),size(minPts,2));
    false_av.dataset(i).av=zeros(size(eps,2),size(minPts,2));
    for l=1:size(S.ROIs.ROI,2)
        false_pos.dataset(i).av=false_pos.dataset(i).av+false_pos.dataset(i).ROI(l).dbscan;
        false_neg.dataset(i).av=false_neg.dataset(i).av+false_neg.dataset(i).ROI(l).dbscan;
        false_av.dataset(i).av=false_av.dataset(i).av+false_av.dataset(i).ROI(l).dbscan;
    end %average over ROIs:
    false_pos.dataset(i).av=false_pos.dataset(i).av./size(S.ROIs.ROI,2);
    false_neg.dataset(i).av=false_neg.dataset(i).av./size(S.ROIs.ROI,2);
    false_av.dataset(i).av=false_av.dataset(i).av./size(S.ROIs.ROI,2);
    
%     figure
%     surf(minPts, eps, false_pos.dataset(i).av);
%     xlabel('minPts');
%     ylabel('eps');
%     zlabel('False positives');
%     box on

%     figure
%     surf(minPts, eps, false_neg.dataset(i).av);
%     xlabel('minPts');
%     ylabel('eps');
%     zlabel('False negatives');
%     box on

%     figure
%     surf(minPts, eps, false_av.dataset(i).av);
%     xlabel('minPts');
%     ylabel('eps');
%     zlabel('Average false positives and negatives');
%     box on
end

%% Find minimum per dataset - compute separate for each ROI, then average
for i=1:size(workspaces,2)
    minima.dataset(i).av_minimum_eps=0;
    minima.dataset(i).av_minimum_minPts=0;
    minima.dataset(i).av_minimum_val=0;
    for l=1:size(S.ROIs.ROI,2)
        [min_val,idx]=min(false_av.dataset(i).ROI(l).dbscan(:));
        [row,col]=ind2sub(size(false_av.dataset(i).ROI(l).dbscan),idx);
        minima.dataset(i).ROI(l).minimum_eps=eps(row);
        minima.dataset(i).av_minimum_eps=minima.dataset(i).av_minimum_eps+minima.dataset(i).ROI(l).minimum_eps;
        minima.dataset(i).ROI(l).minimum_minPts=minPts(col);
        minima.dataset(i).av_minimum_minPts=minima.dataset(i).av_minimum_minPts+minima.dataset(i).ROI(l).minimum_minPts;
        minima.dataset(i).ROI(l).minimum_val=min_val;
        minima.dataset(i).av_minimum_val=minima.dataset(i).av_minimum_val+minima.dataset(i).ROI(l).minimum_val;
    end
    minima.dataset(i).av_minimum_eps=minima.dataset(i).av_minimum_eps/size(S.ROIs.ROI,2);
    minima.dataset(i).av_minimum_minPts=minima.dataset(i).av_minimum_minPts/size(S.ROIs.ROI,2);
    minima.dataset(i).av_minimum_val=minima.dataset(i).av_minimum_val/size(S.ROIs.ROI,2);
end

%% Average over all datasets
false_av.overall=zeros(size(eps,2),size(minPts,2));
for i=1:size(workspaces,2)
    false_av.overall = false_av.overall+false_av.dataset(i).av;
end
false_av.overall=false_av.overall./size(workspaces,2);

%% Plot result in a surface plot
figure
surf(minPts, eps, false_av.overall);
xlabel('minPts');
ylabel('eps');
zlabel('Average false positives and negatives - averaged over datasets');
box on

%% Find minimum for averaged results
[min_val_av,idx_av]=min(false_av.overall(:));
[row_av,col_av]=ind2sub(size(false_av.overall),idx_av);
minima.av_minimum_eps=eps(row_av);
minima.av_minimum_minPts=minPts(col_av);
minima.av_minimum_val=min_val_av;