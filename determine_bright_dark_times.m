function intensity_data = determine_bright_dark_times(object_data, intensity_data, analysis_data)

for i=1:object_data.number %loop over all objects
    intensity_per_ROI = intensity_data.object(i).timetrace_disc; %create a row vector for each ROI, giving the intensity sequence
    change_condition = [true, diff(intensity_per_ROI) ~= 0, true];  % generate a 'true' for value change
    number_repititions = diff(find(change_condition));                % count the number of repetitions
    number_repititions(end)=[];                        % discard the last number of repetitions, as this one was cut off by ending measurement%
    if size(number_repititions,2)>1
        
    number_repititions(1)=[];
    end
    number_repititions = number_repititions*analysis_data.dt;
    if intensity_per_ROI(1)==0  
      intensity_data.object(i).bright_times =  number_repititions(1:2:end);
      intensity_data.object(i).dark_times = number_repititions(2:2:end);
    else %then the last number of repetitions corresponds to a bright time
       intensity_data.object(i).bright_times = number_repititions(2:2:end);
       intensity_data.object(i).dark_times = number_repititions(1:2:end);
    end
end