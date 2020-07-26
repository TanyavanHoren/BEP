function ana = determine_corr_averages_and_binding_spots(ana, set, i)
%{
Determine the average dark and bright time from exponential fits to the
    corrected dark time histogram and bright time histogram respectively. 
    Determine the number of binding sites from the average dark time. 

INPUTS
-------
ana (ana.ROI(i).timetrace_data): contains results from analysis. In the 
this struct, the individual bright and dark times are saved. 
set: system settings

OUTPUTS 
------
ana: contains results from analysis. In this struct, the average bright
and dark time, and the number of binding sites determined are saved. 

Created by Tanya van Horen - July 2020
%}
 
%%
ana.ROI(i).timetrace_data.av_bright_time_corr=expfit(ana.ROI(i).timetrace_data.ontime_corr(:));
ana.ROI(i).timetrace_data.av_dark_time_corr=expfit(ana.ROI(i).timetrace_data.offtime_corr(:));
ana.ROI(i).timetrace_data.number_bind_calculated_corr=set.sample.td/ana.ROI(i).timetrace_data.av_dark_time_corr;
end