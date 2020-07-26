function ana = determine_averages_and_binding_spots(ana, set)
%{
Determine the average dark and bright time from exponential fits to the
dark time histogram and bright time histogram respectively. Determine
the number of binding sites from the average dark time. 

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
for i=1:set.ROI.number
ana.ROI(i).timetrace_data.av_bright_time=expfit(ana.ROI(i).timetrace_data.ontime(:));
ana.ROI(i).timetrace_data.av_dark_time=expfit(ana.ROI(i).timetrace_data.offtime(:));
ana.ROI(i).timetrace_data.number_bind_calculated=set.sample.td/ana.ROI(i).timetrace_data.av_dark_time;
end
end