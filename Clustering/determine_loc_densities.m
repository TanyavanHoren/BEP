function voronoi_var = determine_loc_densities(voronoi_var,i)

voronoi_var.ROI(i).areas = zeros(length(voronoi_var.ROI(i).cells),1);
for j = 1:length(voronoi_var.ROI(i).cells)
    x_pos_vert = voronoi_var.ROI(i).vert(voronoi_var.ROI(i).cells{j},1); 
    y_pos_vert = voronoi_var.ROI(i).vert(voronoi_var.ROI(i).cells{j},2); 
    voronoi_var.ROI(i).areas(j) = polyarea(x_pos_vert,y_pos_vert); %find the area of each cell
end
%we now have the area of each cell, and we can find the local densities
for j = 1:length(voronoi_var.ROI(i).cells)
    indices=voronoi_var.ROI(i).cells{j};
    overlap_number=zeros(1,length(voronoi_var.ROI(i).cells));
    for k=1:length(voronoi_var.ROI(i).cells)
        for l=1:length(indices)
            if ismember(indices(l),voronoi_var.ROI(i).cells{k})==1
                overlap_number(k)=overlap_number(k)+1;
            end
        end
    end
    neighbour_logical=overlap_number>1; %if two vertices in common, then rank 1 neighbour
    voronoi_var.ROI(i).n(j)=sum(neighbour_logical); %point itself + # rank 1 nb
    voronoi_var.ROI(i).A(j)=sum(voronoi_var.ROI(i).areas(neighbour_logical==1)); %area itself + areas nb
    voronoi_var.ROI(i).delta(j)=voronoi_var.ROI(i).n(j)/voronoi_var.ROI(i).A(j); %local density
end
plot_density_hist_vonoroi(voronoi_var,i)
end