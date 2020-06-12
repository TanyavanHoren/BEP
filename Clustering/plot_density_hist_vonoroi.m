function density_hist_vonoroi = plot_density_hist_vonoroi(voronoi_var,i)

figure
[~,edges] = histcounts(log10(voronoi_var.ROI(i).delta));
histogram(voronoi_var.ROI(i).delta,10.^edges)
set(gca, 'xscale','log')
end