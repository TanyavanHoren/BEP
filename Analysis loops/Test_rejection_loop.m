function [false_positives, false_negatives, false_overall] = Test_rejection_loop(calibration, makePlot, workspaces, av_binding_spots, freq_ratio, m)

%% Determine false/true positives/negatives
for i=1:size(workspaces,2)
    S = load(workspaces(i));
    for l=1:size(S.ROIs.ROI,2) %for each ROI separately, analysis is done
        S.i=l;
        [estimation.dataset(i).ROI(l).estimation, checks.dataset(i).ROI(l).check] = Test_rejection(calibration, S, makePlot);
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
false_positives.averages=nanmean(concat_false_positives,3);
false_positives.std=nanstd(concat_false_positives,[],3);

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
false_negatives.averages=-nanmean(concat_false_negatives,3);
false_negatives.std=-nanstd(concat_false_negatives,[],3);

%% Result average false positives and negatives
concat_false_overall=concat_false_positives+concat_false_negatives;
false_overall.averages=nanmean(concat_false_overall,3);
false_overall.std=nanstd(concat_false_overall,[],3);

% figure
% b.false_overall=bar(false_overall.averages, 'grouped');
% hold on
% nbars=size(false_overall.averages,2);
% x_errorbar=[];
% for r=1:nbars
%     x_errorbar=[x_errorbar; b.false_overall(r).XEndPoints];
% end
% errorbar(x_errorbar',false_overall.averages,false_overall.std,'k','linestyle','none')'; 
% legend('Error ellipse','DBSCAN','GMM');
% newXticklabel = {};
% for n=1:size(freq_ratio,2)
%     newXticklabel{n}=[num2str(freq_ratio(n))];
% end
% set(gca,'XtickLabel',newXticklabel);
% xlabel('Ratio specific to non-specific')
% ylabel('Relative number of overall false assigments')
% set(gca, 'YScale', 'log')
% box on
% title(['Average overall false assignments - ',num2str(av_binding_spots(m)),' binding spots'])

%% Plot
figure
b.false_positives=bar(false_positives.averages, 'grouped');
b.false_positives(1).FaceColor = [0 0.4470 0.7410];
b.false_positives(2).FaceColor = [0.8500 0.3250 0.0980];
b.false_positives(3).FaceColor = [0.9290 0.6940 0.1250];
hold on
nbars=size(false_positives.averages,2);
x_errorbar=[];
for r=1:nbars
    x_errorbar=[x_errorbar; b.false_positives(r).XEndPoints];
end
errorbar(x_errorbar',false_positives.averages,false_positives.std,'k','linestyle','none')'; 
hold on 
b.false_negatives=bar(false_negatives.averages, 'grouped');
b.false_negatives(1).FaceColor = [0 0.4470 0.7410];
b.false_negatives(2).FaceColor = [0.8500 0.3250 0.0980];
b.false_negatives(3).FaceColor = [0.9290 0.6940 0.1250];
hold on
nbars=size(false_negatives.averages,2);
x_errorbar=[];
for r=1:nbars
    x_errorbar=[x_errorbar; b.false_negatives(r).XEndPoints];
end
errorbar(x_errorbar',false_negatives.averages,false_negatives.std,'k','linestyle','none')'; 
legend('Error ellipse','DBSCAN', 'GMM');
newXticklabel = {[num2str(freq_ratio(1))],[num2str(freq_ratio(2))],[num2str(freq_ratio(3))]};
set(gca, 'YAxisLocation', 'origin')                                      % Set New Y-Tick Labels
set(gca,'XtickLabel',newXticklabel);
xlabel('Ratio specific to non-specific')
ylabel('Fraction of false assignments')
box on
title(['False assignments - ',num2str(av_binding_spots(m)),' binding spots'])