%{
Determine how many ROIs are needed per dataset to minimize variation in 
the mean number of false positives or negatives, while keeping the data
generation time at an acceptable level. 

INPUTS
-------
none

OUTPUTS (most relevant result)
------
Plots of the width of the 95% confidence interval around the mean number
of false positives/negatives as a function of the sample size (ROI number)

Created by Tanya van Horen - July 2020
%}

%%
clear all
close all
clc

%% Settings
new_data_generated = 0; %1: yes or 0: no
n_steps=50;
makePlot=0;
calibration.dbscan = 'calibration_dbscan_30_06_2020';

%% Generate data
if new_data_generated == 1
    S.set.obj.av_binding_spots=10;
    S.set.para.freq_ratio=0.5;
    S.set.other.fixed_bind_spots=0;
    S.set.ROI.number=150;
    S.set.other.system_choice = 1; %1: spherical particle, 2: nanorod
    [ana, i, ROIs, set, time_trace_data, time_trace_data_non, time_trace_data_spec] = Generate_datasets(S);
    filename = strcat('C:\Users\20174314\Dropbox\_Y3Q4\BEP\BEP Dropbox\Code\Test cases\ROI_number_calibration_bind_10_ratio_0.5_workspace.mat');
    save(filename);
end
if new_data_generated == 1
    S.set.obj.av_binding_spots=100;
    S.set.para.freq_ratio=0.5;
    S.set.other.fixed_bind_spots=0;
    S.set.ROI.number=150;
    S.set.other.system_choice = 1; %1: spherical particle, 2: nanorod
    [ana, i, ROIs, set, time_trace_data, time_trace_data_non, time_trace_data_spec] = Generate_datasets(S);
    filename = strcat('C:\Users\20174314\Dropbox\_Y3Q4\BEP\BEP Dropbox\Code\Test cases\ROI_number_calibration_bind_100_ratio_0.5_workspace.mat');
    save(filename);
end
if new_data_generated == 1
    S.set.obj.av_binding_spots=10;
    S.set.para.freq_ratio=2;
    S.set.other.fixed_bind_spots=0;
    S.set.ROI.number=150;
    S.set.other.system_choice = 1; %1: spherical particle, 2: nanorod
    [ana, i, ROIs, set, time_trace_data, time_trace_data_non, time_trace_data_spec] = Generate_datasets(S);
    filename = strcat('C:\Users\20174314\Dropbox\_Y3Q4\BEP\BEP Dropbox\Code\Test cases\ROI_number_calibration_bind_10_ratio_2_workspace.mat');
    save(filename);
end

%% Do rejection analysis
filename = strcat('C:\Users\20174314\Dropbox\_Y3Q4\BEP\BEP Dropbox\Code\Test cases\ROI_number_calibration_bind_10_ratio_0.5_workspace.mat');
S = load(filename);
for l=1:size(S.ROIs.ROI,2) 
    S.i=l;
    [~, checks.ROI(l).check] = Test_rejection(calibration, S, makePlot);
end

%% False positives
false_positives=[];
concat_false_positives=[];
for m=1:n_steps
    for l=1:size(S.ROIs.ROI,2)*m/n_steps
        false_positives.ROI(l).fp(1,:)=[checks.ROI(l).check.false_pos];
        concat_false_positives(:,:,l) = false_positives.ROI(l).fp;
    end
    false_positives.averages(m,:)=nanmean(concat_false_positives,3);
    false_positives.std(m,:)=nanstd(concat_false_positives,[],3);
    [mu_default,interval_default]=expfit(reshape(concat_false_positives(1,1,:),size(S.ROIs.ROI,2)*m/n_steps,1)');
    width_interval_fp(m,1)=interval_default(2)-interval_default(1);
    [mu_dbscan,interval_dbscan]=expfit(reshape(concat_false_positives(1,2,:),size(S.ROIs.ROI,2)*m/n_steps,1)');
    width_interval_fp(m,2)=interval_dbscan(2)-interval_dbscan(1);
    [mu_gmm,interval_gmm]=expfit(reshape(concat_false_positives(1,3,:),size(S.ROIs.ROI,2)*m/n_steps,1)');
    width_interval_fp(m,3)=interval_gmm(2)-interval_gmm(1);
end
ROI_number=size(S.ROIs.ROI,2)/n_steps:size(S.ROIs.ROI,2)/n_steps:size(S.ROIs.ROI,2);
figure
plot(ROI_number, false_positives.averages(:,1), '-o', ROI_number, false_positives.averages(:,2), '-x', ROI_number, false_positives.averages(:,3),'-*')
xlabel('Number of ROIs')
ylabel('Average')
xlim([size(S.ROIs.ROI,2)/n_steps inf]);
box on
title(['Average - false positives'])
legend('Error ellipse','DBSCAN', 'GMM');

figure 
plot(ROI_number, width_interval_fp(:,1), '-o', ROI_number, width_interval_fp(:,2), '-x', ROI_number, width_interval_fp(:,3),'-*')
xlabel('Number of ROIs')
ylabel('Average width 95% confidence interval')
xlim([size(S.ROIs.ROI,2)/n_steps inf]);
box on
title(['Confidence interval - false positives'])
legend('Error ellipse','DBSCAN', 'GMM');

%% False negatives
false_negatives=[];
concat_false_negatives=[];
for m=1:n_steps
    for l=1:size(S.ROIs.ROI,2)*m/n_steps
        false_negatives.ROI(l).fn(1,:)=[checks.ROI(l).check.false_neg];
        concat_false_negatives(:,:,l) = false_negatives.ROI(l).fn;
    end
    false_negatives.averages(m,:)=nanmean(concat_false_negatives,3);
    false_negatives.std(m,:)=nanstd(concat_false_negatives,[],3);
    [mu_default,interval_default]=expfit(reshape(concat_false_negatives(1,1,:),size(S.ROIs.ROI,2)*m/n_steps,1)');
    width_interval_fn(m,1)=interval_default(2)-interval_default(1);
    [mu_dbscan,interval_dbscan]=expfit(reshape(concat_false_negatives(1,2,:),size(S.ROIs.ROI,2)*m/n_steps,1)');
    width_interval_fn(m,2)=interval_dbscan(2)-interval_dbscan(1);
    [mu_gmm,interval_gmm]=expfit(reshape(concat_false_negatives(1,3,:),size(S.ROIs.ROI,2)*m/n_steps,1)');
    width_interval_fn(m,3)=interval_gmm(2)-interval_gmm(1);
end
ROI_number=size(S.ROIs.ROI,2)/n_steps:size(S.ROIs.ROI,2)/n_steps:size(S.ROIs.ROI,2);
figure
plot(ROI_number, false_negatives.averages(:,1), '-o', ROI_number, false_negatives.averages(:,2), '-x', ROI_number, false_negatives.averages(:,3),'-*')
xlabel('Number of ROIs')
ylabel('Average')
xlim([size(S.ROIs.ROI,2)/n_steps inf]);
box on
title(['Average - false negatives'])
legend('Error ellipse','DBSCAN', 'GMM');

figure
plot(ROI_number, width_interval_fn(:,1), '-o', ROI_number, width_interval_fn(:,2), '-x', ROI_number, width_interval_fn(:,3),'-*')
xlabel('Number of ROIs')
ylabel('Average width 95% confidence interval')
xlim([size(S.ROIs.ROI,2)/n_steps inf]);
box on
title(['Confidence interval - false negatives'])
legend('Error ellipse','DBSCAN', 'GMM');