clear all
close all
clc

%% Give datasets to analyze 
%workspaces=["non05bind5.mat", "non05bind20.mat", "non05bind100.mat", "non1bind5.mat", "non1bind20.mat", "non1bind100.mat", "non10bind5.mat", "non10bind20.mat", "non10bind100.mat"];
%workspaces=["non1bind20.mat"];
workspaces=["Circle_bind_5_ratio_10_workspace.mat", "Circle_bind_5_ratio_0.5_workspace.mat", "Circle_bind_5_ratio_0.1_workspace.mat"];

%% Determine false/true positives/negatives
for i=1:size(workspaces,2)
    S = load(workspaces(i));
    for l=1:size(S.ROIs.ROI,2) %for each ROI separately, analysis is done
        S.i=l;
        [estimation.dataset(i).ROI(l).estimation, checks.dataset(i).ROI(l).check] = Test_rejection(S,0);
    end
end

%% Result false positives 
false_positives=[];
concat_false_positives=[];
for l=1:size(S.ROIs.ROI,2)
    counter = 1;
    for i=1:size(workspaces,2)
        false_positives.ROI(l).fp(counter,:)=[checks.dataset(i).ROI(l).check.false_pos];
        counter=counter+1;
    end
    concat_false_positives(:,:,l) = false_positives.ROI(l).fp;
end
false_positives.averages=mean(concat_false_positives,3);
false_positives.std=std(concat_false_positives,[],3);

figure
b.false_positives=bar(false_positives.averages, 'grouped');
hold on
nbars=size(false_positives.averages,2);
x_errorbar=[];
for r=1:nbars
    x_errorbar=[x_errorbar; b.false_positives(r).XEndPoints];
end
errorbar(x_errorbar',false_positives.averages,false_positives.std,'k','linestyle','none')'; 
legend('Error ellipse','DBSCAN without fitting', 'DBSCAN with fitting', 'GMM without fitting', 'GMM with fitting');
xlabel('Dataset')
ylabel('Relative number of false positives')
box on
title('False positives')

%% Result false negatives
false_negatives=[];
for l=1:size(S.ROIs.ROI,2)
    counter = 1;
    for i=1:size(workspaces,2)
        false_negatives.ROI(l).fn(counter,:)=[checks.dataset(i).ROI(l).check.false_neg];
        counter=counter+1;
    end
    concat_false_negatives(:,:,l) = false_negatives.ROI(l).fn;
end
false_negatives.averages=mean(concat_false_negatives,3);
false_negatives.std=std(concat_false_negatives,[],3);

figure
b.false_negatives=bar(false_negatives.averages, 'grouped');
hold on
nbars=size(false_negatives.averages,2);
x_errorbar=[];
for r=1:nbars
    x_errorbar=[x_errorbar; b.false_negatives(r).XEndPoints];
end
errorbar(x_errorbar',false_negatives.averages,false_negatives.std,'k','linestyle','none')'; 
legend('Error ellipse','DBSCAN without fitting', 'DBSCAN with fitting', 'GMM without fitting', 'GMM with fitting');
xlabel('Dataset')
ylabel('Relative number of false negatives')
box on
title('False negatives')

%% Result average false positives and negatives
false_av_overall=(false_positives.averages+false_negatives.averages)/2;
false_std_overall=(false_positives.std+false_negatives.std)/2;

figure
b.false_av_overall=bar(false_av_overall, 'grouped');
hold on
nbars=size(false_av_overall,2);
x_errorbar=[];
for r=1:nbars
    x_errorbar=[x_errorbar; b.false_av_overall(r).XEndPoints];
end
errorbar(x_errorbar',false_av_overall,false_std_overall,'k','linestyle','none')'; 
legend('Error ellipse','DBSCAN without fitting', 'DBSCAN with fitting', 'GMM without fitting', 'GMM with fitting');
xlabel('Dataset')
ylabel('Relative number of overall false assigments')
box on
title('Average overall false assignments')