function ana = merge_events(set,ana,i,frame_data)

indices = zeros(1,set.mic.frames);
for j=1:set.mic.frames
    indices(1,j)=j;
end
end_tracker = [];
begin_tracker = [];
dark_indices = indices(ana.ROI(i).timetrace_data.labeledOns==0);
for j=2:size(dark_indices,2)
    if dark_indices(j)-dark_indices(j-1)>1.5
        end_frame = dark_indices(j)-1;
        begin_frame = dark_indices(j-1)+1;
        event_length = end_frame - begin_frame + 1;
        end_tracker = [end_tracker end_frame];
        begin_tracker = [begin_tracker begin_frame];
        frames_merged = uint16(zeros(set.ROI.size,set.ROI.size));
        if end_frame == begin_frame
            frames_merged(:,:) = frames_merged(:,:) + frame_data.ROI(i).frame(:,:,begin_frame); % right
        else
            for k = begin_frame:1:end_frame
                frames_merged(:,:) = frames_merged(:,:) + frame_data.ROI(i).frame(:,:,k); % right
            end
        end
    end
end