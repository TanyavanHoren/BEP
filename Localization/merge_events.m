function merged_frame_data = merge_events(ana,i,frame_data)

for j=1:size(ana.ROI(i).timetrace_data.ontime,2)
    logical = ana.ROI(i).timetrace_data.labeledOns==j;
    merged_frame_data.ROI(i).frame(:,:,j)=sum(frame_data.ROI(i).frame(:,:,logical),3);
end
end
