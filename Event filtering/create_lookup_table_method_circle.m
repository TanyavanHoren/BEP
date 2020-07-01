function optimization_method = create_lookup_table_method_circle(av_binding_spots, freq_ratio,circle_series)

for m=1:size(av_binding_spots,2)
    for n=1:size(freq_ratio,2)
        minimum = min(circle_series(m).false_overall.averages(n,:)); %find column index for each row (row is ratio)
        k=find(circle_series(m).false_overall.averages(n,:)'==minimum);
        optimization_method.circle.method(m,n)=k(1);
    end
end
end