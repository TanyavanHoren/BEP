function optimization_dbscan = create_lookup_table_dbscan_rectangle(av_binding_spots,freq_ratio,opt,optimization_dbscan)

for m=1:size(av_binding_spots,2)
    for n=1:size(freq_ratio,2)
        i=(m-1)*size(freq_ratio,2)+n;
        optimization_dbscan.rectangle.eps(m,n)=opt.rectangle.minima.dataset(i).av_minimum_eps;
        optimization_dbscan.rectangle.minPts(m,n)=opt.rectangle.minima.dataset(i).av_minimum_minPts;
        optimization_dbscan.rectangle.val(m,n)=opt.rectangle.minima.dataset(i).av_minimum_val;
    end
end
end