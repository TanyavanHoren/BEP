function ana = reject_bright_dark_new(ana, i)

if ana.ROI(i).timetrace_data.labeledOns(1)==0
    begin_bright=0; %at the beginning, we have a dark time
else
    begin_bright=1;
end

data = [[ana.ROI(i).SupResParams.frame_idx]' [ana.ROI(i).SupResParams.isOutlier]']; 
data(data(:,2) == 0,:)=[]; %select frames of rejected events 
on_time_log=false(1,length(ana.ROI(i).timetrace_data.ontime)); 
off_time_log=false(1,length(ana.ROI(i).timetrace_data.offtime));
[dark_new]=[];
counter=0;

for j=1:length(data)
    bright_index = ana.ROI(i).timetrace_data.labeledOns(data(j,1)); %find # bright time
    if bright_index == 0
        continue
    end
    on_time_log(1,bright_index)=true;
    try
        off_time_log(1,bright_index-begin_bright)=true;
        off_time_log(1,bright_index+1-begin_bright)=true;
    end
end

for j=1+begin_bright:length(on_time_log) %we calculate based on dark times before a bright time
    if on_time_log(j)==1
        counter=counter+ana.ROI(i).timetrace_data.ontime(j)+ana.ROI(i).timetrace_data.offtime(j-begin_bright);
    end 
    if on_time_log(j)==0 && counter>0
        counter=counter+ana.ROI(i).timetrace_data.offtime(j-begin_bright);
        [dark_new] = [dark_new counter];
        counter = 0;
    end  
end

if counter>0 %if the last bright time was non-specific -> still have to save
    if length(off_time_log)-(1-begin_bright)==length(on_time_log) %add last dark time
        counter = counter+ana.ROI(i).timetrace_data.offtime(length(off_time_log));
    end
    dark_new = [dark_new counter];
end

ana.ROI(i).timetrace_data.ontime_corr =  ana.ROI(i).timetrace_data.ontime;
ana.ROI(i).timetrace_data.ontime_corr(on_time_log)=[];
ana.ROI(i).timetrace_data.offtime_corr =  ana.ROI(i).timetrace_data.offtime;
ana.ROI(i).timetrace_data.offtime_corr(off_time_log)=[];
ana.ROI(i).timetrace_data.offtime_corr = [ana.ROI(i).timetrace_data.offtime_corr dark_new];

end