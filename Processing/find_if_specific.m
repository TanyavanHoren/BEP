function res = find_if_specific(ana, obj,set)

for i=1:ana.ROI.number
    for j=1:obj.gen.number
        if ana.ROI.ROI(i).lower_bound_x<obj.object(j).position_x/set.mic.pixelsize && obj.object(j).position_x/set.mic.pixelsize<ana.ROI.ROI(i).upper_bound_x && ana.ROI.ROI(i).lower_bound_y<obj.object(j).position_y/set.mic.pixelsize && ana.ROI.ROI(i).lower_bound_y<ana.ROI.ROI(i).upper_bound_y
            res.ROI(i).label=1; %if an object is present within the bounds, it is likely to be specific
            break
        else
            res.ROI(i).label=0;
        end
    end
end
end
