% Example data as before
model_series = [10 40 50 60; 20 50 60 70; 30 60 80 90];
model_error = [1 4 8 6; 2 5 9 12; 3 6 10 13];
b = bar(model_series, 'grouped');

%%For MATLAB 2019b or later releases
hold on
% Calculate the number of bars in each group
nbars = size(model_series, 2);
% Get the x coordinate of the bars
x = [];
for i = 1:nbars
    x = [x ; b(i).XEndPoints];
end
% Plot the errorbars
errorbar(x',model_series,model_error,'k','linestyle','none')'
hold off