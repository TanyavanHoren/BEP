function ROIs = shuffle(ROIs, set, i)

ROIs = generate_binding_events(ROIs, set, set.other.t_shuffle, i);
for j=1:ROIs.ROI(i).object_number_bind
    ROIs.ROI(i).site(j).t_switch = ROIs.ROI(i).site(j).t_switch - set.other.t_shuffle;
end
end
