function res = determine_bright_dark_times(res, ana, set)

for i=1:ana.ROI.number %loop over all ROIs
    intensity_per_ROI = ana.ROI.ROI(i).timetrace_disc; %create a row vector for each ROI, giving the intensity sequence
    change_condition = [true, diff(intensity_per_ROI) ~= 0, true]; % generate a 'true' for value change
    number_repititions = diff(find(change_condition)); % count the number of repetitions
    number_repititions(end)=[]; % discard the last element (due to cutoff)
    if size(number_repititions,2)>1
        number_repititions(1)=[]; %discard the first element
    end
    number_repititions = number_repititions*set.mic.dt;
    if intensity_per_ROI(1)==0 %then start unbound, so second repetition number is bright time
        res.ROI(i).bright_times =  number_repititions(1:2:end);
        res.ROI(i).dark_times = number_repititions(2:2:end);
    else
        res.ROI(i).bright_times = number_repititions(2:2:end);
        res.ROI(i).dark_times = number_repititions(1:2:end);
    end
    if set.other.ROI_mode == 3
        res.ROI(i).label=ana.ROI.ROI(i).label;
    end
end
end