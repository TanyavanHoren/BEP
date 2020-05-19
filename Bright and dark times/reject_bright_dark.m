function ana = reject_bright_dark(ana, i)

if ana.ROI(i).timetrace_data.labeledOns(1)==0
    begin_dark=1; %at the beginning, we have a dark time
else
    begin_dark=0;
end

data = [[ana.ROI(i).SupResParams.frame_idx]' [ana.ROI(i).SupResParams.isOutlier]'];
data(data(:,2) == 0,:)=[];
on_time_log=false(1,length(ana.ROI(i).timetrace_data.ontime));
off_time_log=false(1,length(ana.ROI(i).timetrace_data.ontime));

for j=1:length(data)
    bright_index = ana.ROI(i).timetrace_data.labeledOns(data(j,1)); %find # bright time
    if bright_index == 0
        break
    end
        on_time_log(1,bright_index)=true;
    if begin_dark==1
        off_time_log(1,bright_index)=true;
        try
            off_time_log(1,bright_index+1)=true;
        end
    elseif begin_dark==0
        try
            off_time_log(1,bright_index-1)=true;
        end
        off_time_log(1,bright_index)=true;
    end
end

 ana.ROI(i).timetrace_data.ontime_corr =  ana.ROI(i).timetrace_data.ontime;
 ana.ROI(i).timetrace_data.ontime_corr(on_time_log)=[];
 ana.ROI(i).timetrace_data.offtime_corr =  ana.ROI(i).timetrace_data.offtime;
 ana.ROI(i).timetrace_data.offtime_corr(off_time_log)=[];
end
