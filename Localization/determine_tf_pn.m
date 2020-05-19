function check = determine_tf_pn(ana, i)

true_pos_log=false(1,size(ana.ROI(i).SupResParams,2));
true_neg_log=false(1,size(ana.ROI(i).SupResParams,2));
false_pos_log=false(1,size(ana.ROI(i).SupResParams,2));
false_neg_log=false(1,size(ana.ROI(i).SupResParams,2));
for j=1:size(ana.ROI(i).SupResParams,2)
    true_pos_log(j)=sum(ana.ROI(i).SupResParams(j).isOutlier==0 && ana.ROI(i).SupResParams(j).isNonSpecific==0); %0(not outlier), 0(specific)
    true_neg_log(j)=sum(ana.ROI(i).SupResParams(j).isOutlier==1 && ana.ROI(i).SupResParams(j).isNonSpecific==1); %1(outlier), 1(non-specific)
    false_pos_log(j)=sum(ana.ROI(i).SupResParams(j).isOutlier==0 && ana.ROI(i).SupResParams(j).isNonSpecific==1);%0(not outlier), 1(non-specific)
    false_neg_log(j)=sum(ana.ROI(i).SupResParams(j).isOutlier==1 && ana.ROI(i).SupResParams(j).isNonSpecific==0); %1(Outlier), 0(specific)
end
check.true_pos=sum(true_pos_log);
check.true_neg=sum(true_neg_log);
check.false_pos=sum(false_pos_log);
check.false_neg=sum(false_neg_log);
end