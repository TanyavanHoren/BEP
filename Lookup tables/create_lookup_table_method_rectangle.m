function optimization_method = create_lookup_table_method_rectangle(optimization_method, av_binding_spots, freq_ratio, rectangle_series)
%{
Make a lookup table showing the optimal clustering algorithm for each
combination of the average number of binding sites and ratio of specific
to non-specific events tested. 

INPUTS
-------
optimization_method: lookup table; struct that this script should append do
av_binding_spots: average binding site numbers tested
freq_ratio: ratios of specific to non-specific events tested
rectangle_series: results from clustering analysis for rectangular particles

OUTPUTS 
------
optimization_method: lookup table

Created by Tanya van Horen - July 2020
%}

%%
for m=1:size(av_binding_spots,2)
    for n=1:size(freq_ratio,2)
        minimum = min(rectangle_series(m).false_overall.averages(n,:)); %find column index for each row (row is ratio)
        k=find(rectangle_series(m).false_overall.averages(n,:)'==minimum);
        optimization_method.rectangle.method(m,n)=k(1);
    end
end
end