function optimization_method = create_lookup_table_method_rectangle(av_binding_spots, freq_ratio, rectangle_series, optimization_method)

for m=1:size(av_binding_spots,2)
    for n=1:size(freq_ratio,2)
        minimum = min(rectangle_series(m).false_overall.averages(n,:)); %find column index for each row (row is ratio)
        k=find(rectangle_series(m).false_overall.averages(n,:)'==minimum);
        optimization_method.rectangle.method(m,n)=k(1);
    end
end
end