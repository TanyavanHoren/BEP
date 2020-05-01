function res = determine_bright_dark_times(ana, set)

for i=1:ana.ROI.number %loop over all ROIs
    intensity_per_ROI = ana.ROI.ROI(i).timetrace_disc; %create a row vector for each ROI, giving the intensity sequence
    change_condition = [true, diff(intensity_per_ROI) ~= 0, true];  % generate a 'true' for value change
    number_repititions = diff(find(change_condition));                % count the number of repetitions
    number_repititions(end)=[];                        % discard the last number of repetitions, as this one was cut off by ending measurement%
    if size(number_repititions,2)>1
        number_repititions(1)=[];
    end
    number_repititions = number_repititions*set.mic.dt;
    if intensity_per_ROI(1)==0
        res.ROI(i).bright_times =  number_repititions(1:2:end);
        res.ROI(i).dark_times = number_repititions(2:2:end);
    else %then the last number of repetitions corresponds to a bright time
        res.ROI(i).bright_times = number_repititions(2:2:end);
        res.ROI(i).dark_times = number_repititions(1:2:end);
    end
    res.ROI(i).label=ana.ROI.ROI(i).label; 
end