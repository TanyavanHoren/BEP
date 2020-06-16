function density_hist_vonoroi = plot_density_hist_vonoroi(voronoi_var,i)

figure
[~,edges] = histcounts(log10(voronoi_var.ROI(i).delta));
histogram(voronoi_var.ROI(i).delta,10.^edges)
set(gca, 'xscale','log')
%normalization with respect to average density
figure
[~,edges] = histcounts(log10(voronoi_var.ROI(i).delta_norm));
histogram(voronoi_var.ROI(i).delta_norm,10.^edges)
set(gca, 'xscale','log')
%normalization with respect to random distribution 
figure
[~,edges] = histcounts(log10(voronoi_var.ROI(i).delta_norm2));
histogram(voronoi_var.ROI(i).delta_norm2,10.^edges)
set(gca, 'xscale','log')
end