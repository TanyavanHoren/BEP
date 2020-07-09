data = [2 3 4 5; -3 -3 -1 -4]';

% subplot(3,1,1),bar(data)
% subplot(3,1,2),bar(data.')
% subplot(3,1,3),bar(data(:,1),0.3)
% hold on
% bar(data(:,2),0.3,'facecolor','y')

bar(data(:,1),0.3)
hold on 
bar(data(:,2),0.3, 'facecolor', 'y')