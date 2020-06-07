function [false_positives, false_negatives, false_overall] = Test_rejection_loop(makePlot, workspaces, av_binding_spots, freq_ratio, m)

%% Determine false/true positives/negatives
for i=1:size(workspaces,2)
    S = load(workspaces(i));
    for l=1:size(S.ROIs.ROI,2) %for each ROI separately, analysis is done
        S.i=l;
        [estimation.dataset(i).ROI(l).estimation, checks.dataset(i).ROI(l).check] = Test_rejection(S, makePlot);
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

% figure
% b.false_positives=bar(false_positives.averages, 'grouped');
% hold on
% nbars=size(false_positives.averages,2);
% x_errorbar=[];
% for r=1:nbars
%     x_errorbar=[x_errorbar; b.false_positives(r).XEndPoints];
% end
% errorbar(x_errorbar',false_positives.averages,false_positives.std,'k','linestyle','none')'; 
% % legend('Error ellipse','DBSCAN', 'GMM');
% newXticklabel = {[num2str(freq_ratio(1))],[num2str(freq_ratio(2))],[num2str(freq_ratio(3))]};
% set(gca,'XtickLabel',newXticklabel);
% xlabel('Ratio specific to non-specific')
% ylabel('Relative number of false positives')
% box on
% title(['False positives - ',num2str(av_binding_spots(m)),' binding spots'])

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

% figure
% b.false_negatives=bar(false_negatives.averages, 'grouped');
% hold on
% nbars=size(false_negatives.averages,2);
% x_errorbar=[];
% for r=1:nbars
%     x_errorbar=[x_errorbar; b.false_negatives(r).XEndPoints];
% end
% errorbar(x_errorbar',false_negatives.averages,false_negatives.std,'k','linestyle','none')'; 
% legend('Error ellipse','DBSCAN', 'GMM');
% newXticklabel = {[num2str(freq_ratio(1))],[num2str(freq_ratio(2))],[num2str(freq_ratio(3))]};
% set(gca,'XtickLabel',newXticklabel);
% xlabel('Ratio specific to non-specific')
% ylabel('Relative number of false negatives')
% box on
% title(['False negatives - ',num2str(av_binding_spots(m)),' binding spots'])

%% Result average false positives and negatives
concat_false_overall=concat_false_positives+concat_false_negatives;
false_overall.averages=mean(concat_false_overall,3);
false_overall.std=std(concat_false_overall,[],3);

figure
b.false_overall=bar(false_overall.averages, 'grouped');
hold on
nbars=size(false_overall.averages,2);
x_errorbar=[];
for r=1:nbars
    x_errorbar=[x_errorbar; b.false_overall(r).XEndPoints];
end
errorbar(x_errorbar',false_overall.averages,false_overall.std,'k','linestyle','none')'; 
legend('Error ellipse','DBSCAN','GMM');
newXticklabel = {};
for n=1:size(freq_ratio,2)
    newXticklabel{n}=[num2str(freq_ratio(n))];
end
set(gca,'XtickLabel',newXticklabel);
xlabel('Ratio specific to non-specific')
ylabel('Relative number of overall false assigments')
box on
title(['Average overall false assignments - ',num2str(av_binding_spots(m)),' binding spots'])