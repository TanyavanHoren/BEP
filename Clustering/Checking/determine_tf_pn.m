function check = determine_tf_pn(ana, i, k, check)
%{
Determine the amount of true positives, false positives, true negatives,
    and false negatives for the considered ROI. 

INPUTS
-------
ana: struct containing the analysis information, such as the classification
    of each event
i: index of the ROI that is considered
k: index of the method that is considered (1:Error ellipse, 2:DBSCAN, 3:GMM)
check: struct containing the amount of false positives and false negatives
    for each method

OUTPUTS 
------
check: struct containing the amount of false positives and false negatives
    for each method (updated)

Created by Tanya van Horen - July 2020
%}

%%
%predefine
true_pos_log=false(1,size(ana.ROI(i).SupResParams,2));
true_neg_log=false(1,size(ana.ROI(i).SupResParams,2));
false_pos_log=false(1,size(ana.ROI(i).SupResParams,2));
false_neg_log=false(1,size(ana.ROI(i).SupResParams,2));
%determine t/f p/n
if k==1
    for j=1:size(ana.ROI(i).SupResParams,2)
        true_pos_log(j)=sum(ana.ROI(i).SupResParams(j).isRej_DEFAULT==0 && ana.ROI(i).SupResParams(j).isNonSpecific==0); %0(not outlier), 0(specific)
        true_neg_log(j)=sum(ana.ROI(i).SupResParams(j).isRej_DEFAULT==1 && ana.ROI(i).SupResParams(j).isNonSpecific==1); %1(outlier), 1(non-specific)
        false_pos_log(j)=sum(ana.ROI(i).SupResParams(j).isRej_DEFAULT==0 && ana.ROI(i).SupResParams(j).isNonSpecific==1);%0(not outlier), 1(non-specific)
        false_neg_log(j)=sum(ana.ROI(i).SupResParams(j).isRej_DEFAULT==1 && ana.ROI(i).SupResParams(j).isNonSpecific==0); %1(Outlier), 0(specific)
    end
elseif k==2
    for j=1:size(ana.ROI(i).SupResParams,2)
        true_pos_log(j)=sum(ana.ROI(i).SupResParams(j).isRej_DBSCAN==0 && ana.ROI(i).SupResParams(j).isNonSpecific==0); %0(not outlier), 0(specific)
        true_neg_log(j)=sum(ana.ROI(i).SupResParams(j).isRej_DBSCAN==1 && ana.ROI(i).SupResParams(j).isNonSpecific==1); %1(outlier), 1(non-specific)
        false_pos_log(j)=sum(ana.ROI(i).SupResParams(j).isRej_DBSCAN==0 && ana.ROI(i).SupResParams(j).isNonSpecific==1);%0(not outlier), 1(non-specific)
        false_neg_log(j)=sum(ana.ROI(i).SupResParams(j).isRej_DBSCAN==1 && ana.ROI(i).SupResParams(j).isNonSpecific==0); %1(Outlier), 0(specific)
    end     
elseif k==3
    for j=1:size(ana.ROI(i).SupResParams,2)
        true_pos_log(j)=sum(ana.ROI(i).SupResParams(j).isRej_GMM==0 && ana.ROI(i).SupResParams(j).isNonSpecific==0); %0(not outlier), 0(specific)
        true_neg_log(j)=sum(ana.ROI(i).SupResParams(j).isRej_GMM==1 && ana.ROI(i).SupResParams(j).isNonSpecific==1); %1(outlier), 1(non-specific)
        false_pos_log(j)=sum(ana.ROI(i).SupResParams(j).isRej_GMM==0 && ana.ROI(i).SupResParams(j).isNonSpecific==1);%0(not outlier), 1(non-specific)
        false_neg_log(j)=sum(ana.ROI(i).SupResParams(j).isRej_GMM==1 && ana.ROI(i).SupResParams(j).isNonSpecific==0); %1(Outlier), 0(specific)
    end
end
check(k).true_pos=sum(true_pos_log);
check(k).true_neg=sum(true_neg_log);
check(k).false_pos=sum(false_pos_log);
check(k).false_neg=sum(false_neg_log);
end