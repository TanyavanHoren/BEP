function optimization_dbscan = create_lookup_table_dbscan_rectangle(av_binding_spots,freq_ratio,opt,optimization_dbscan)
%{
Make a lookup table showing the optimal DBSCAN parameters for each
combination of the average number of binding sites and ratio of specific
to non-specific events tested. 

INPUTS
-------
optimization_dbscan: lookup table; struct that this script should append do
av_binding_spots: average binding site numbers tested
freq_ratio: ratios of specific to non-specific events tested
opt: results from DBSCAN analysis

OUTPUTS 
------
optimization_dbscan: lookup table

Created by Tanya van Horen - July 2020
%}

%%
for m=1:size(av_binding_spots,2)
    for n=1:size(freq_ratio,2)
        i=(m-1)*size(freq_ratio,2)+n;
        optimization_dbscan.rectangle.eps(m,n)=opt.rectangle.minima.dataset(i).av_minimum_eps;
        optimization_dbscan.rectangle.minPts(m,n)=opt.rectangle.minima.dataset(i).av_minimum_minPts;
        optimization_dbscan.rectangle.val(m,n)=opt.rectangle.minima.dataset(i).av_minimum_val;
    end
end
end