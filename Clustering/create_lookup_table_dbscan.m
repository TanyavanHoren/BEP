function optimization_dbscan = create_lookup_table_dbscan(av_binding_spots,freq_ratio,opt)

for m=1:size(av_binding_spots,2)
    for n=1:size(freq_ratio,2)
        i=(m-1)*size(freq_ratio,2)+n;
        optimization_dbscan.eps(m,n)=opt.circle.minima.dataset(i).av_minimum_eps;
        optimization_dbscan.minPts(m,n)=opt.circle.minima.dataset(i).av_minimum_minPts;
        optimization_dbscan.val(m,n)=opt.circle.minima.dataset(i).av_minimum_val;
    end
end
end