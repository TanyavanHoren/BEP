function ana = determine_category_events(ana, time_trace_data_non, time_trace_data_spec, i)

non_spec_log = false(1,size(ana.ROI(i).SupResParams,2));
for j=1:size(ana.ROI(i).SupResParams,2)
    if time_trace_data_non.ROI(i).frame(ana.ROI(i).SupResParams(j).frame_idx) == 0 && time_trace_data_spec.ROI(i).frame(ana.ROI(i).SupResParams(j).frame_idx) ~= 0
        non_spec_log(j)=0;
    else
        non_spec_log(j)=1;
    end
end
logical = num2cell(non_spec_log);
[ana.ROI(i).SupResParams.isNonSpecific]=logical{:};
end