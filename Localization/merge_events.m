function merged_frame_data = merge_events(ana,i,frame_data)
%{
Sum all frames corresponding to a single bright time (such that a single
localization can be performed per event). 

INPUTS
-------
ana: struct containing results from analysis. In this case, time trace 
analysis results are needed to find the frames that correspond to the same 
bright time. 
i: index of the ROI considered
frame_data: struct containing all frames

OUTPUTS 
------
merged_frame_data: summed frames 

Created by Tanya van Horen - July 2020
%}

%%
for j=1:size(ana.ROI(i).timetrace_data.ontime,2)
    logical = ana.ROI(i).timetrace_data.labeledOns==j;
    merged_frame_data.ROI(i).frame(:,:,j)=sum(frame_data.ROI(i).frame(:,:,logical),3);
end
end