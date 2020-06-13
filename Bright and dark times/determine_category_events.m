function ana = determine_category_events(ana, time_trace_data_non, time_trace_data_spec, i, makePlot, set, ROIs)

non_spec_log = int16(zeros(1,size(ana.ROI(i).SupResParams,2)));
for j=1:size(ana.ROI(i).SupResParams,2)
    event_index = ana.ROI(i).SupResParams(j).event_idx;
    indices_frames=ana.ROI(i).timetrace_data.labeledOns==event_index;
    n_non = sum(time_trace_data_non.ROI(i).frame(indices_frames));
    n_spec = sum(time_trace_data_spec.ROI(i).frame(indices_frames));
    if n_non == 0 && n_spec > 0
        non_spec_log(j)=0;
    elseif n_non > 0 && n_spec == 0
        non_spec_log(j)=1;
    elseif n_non > 0 && n_spec > 0
        non_spec_log(j)=2;
    elseif n_non == 0 && n_spec == 0
        non_spec_log(j)=3;
    end
end
%0: specific with certainty: only a specific event was going on
%1: non-specific with certainty: only a non-specific event was going on
%2: simultaneous specific and non-specific events: we will reject these from further analysis
%3: there was no event: something was localized, while no event was going on 

ana.ROI(i).numNonSpecific = size(non_spec_log(non_spec_log==1),2);
ana.ROI(i).numSpecific = size(non_spec_log(non_spec_log==0),2);
ana.ROI(i).numOther = size(non_spec_log,2) - ana.ROI(i).numNonSpecific - ana.ROI(i).numSpecific;
logical = num2cell(non_spec_log);
[ana.ROI(i).SupResParams.isNonSpecific]=logical{:};

if makePlot == 1
    visualize_category_events(ana, i, set, ROIs)
end
end