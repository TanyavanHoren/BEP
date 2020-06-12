function voronoi_var = create_voronoi_diagram(ana,i,set)

x=[ana.ROI(i).SupResParams.x_coord]';
y=[ana.ROI(i).SupResParams.y_coord]';
[voronoi_var.ROI(i).vert,voronoi_var.ROI(i).cells] = voronoin([x y]); %create vonoroi diagram for x and y loc -> extract vertices and cells
figure
voronoi(x,y); %plot the vonoroi diagram
xlabel('x-position (pixels)')
ylabel('y-position (pixels)')
xlim([-set.ROI.size/2 set.ROI.size/2])
ylim([([-set.ROI.size/2 set.ROI.size/2])])
box on
title('Voronoi diagram')
end