function time_trace_data_non = create_non_tt(ROIs, i, n_frame, time_trace_data_non)
%{
Keep track of the amount of non-specific events occuring at any 
moment in time.

INPUTS
-------
ROIs: settings for the considered ROI specifically
i: index of considered ROI
n_frame: index of the current frame
time_trace_data_non: the amount of non-specific sites active for each 
moment in time, excluding the current moment in time

OUTPUTS 
------
time_trace_data_non: the amount of non-specific sites active for each 
moment in time, including the current moment in time

Created by Tanya van Horen - July 2020
%}

%%
time_trace_data_non.ROI(i).frame(n_frame(i)) = ROIs.ROI(i).non_specific.number;
end