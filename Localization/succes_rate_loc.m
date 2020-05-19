function ana = succes_rate_loc(ana, i)

ana.ROI(i).succes_rate_loc=size(ana.ROI(i).SupResParams,2)/size(ana.ROI(i).timetrace_data.spikes,2);
end