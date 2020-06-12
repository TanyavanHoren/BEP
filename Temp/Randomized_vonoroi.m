figure
x=[];
y=[];
for j=1:size(ana.ROI(i).SupResParams,2)
    x(j)=-set.ROI.size/2+rand()*set.ROI.size; 
    y(j)=-set.ROI.size/2+rand()*set.ROI.size;
end
[v2,c2] = voronoin([x' y']); %create vonoroi diagram for x and y loc -> extract vertices and cells
voronoi(x',y'); %plot the vonoroi diagram 
xlabel('x-position (pixels)')
ylabel('y-position (pixels)')
xlim([-set.ROI.size/2 set.ROI.size/2])
ylim([([-set.ROI.size/2 set.ROI.size/2])])
box on
title('Voronoi diagram')
A2 = zeros(length(c2),1);
for j = 1:length(c2)
    v12 = v2(c2{j},1); %x positions vertices 
    v22 = v2(c2{j},2); %y positions vertices
    %figure
    %patch(v1,v2,rand(1,3))
    A2(j) = polyarea(v12,v22); %find the area of each cell 
end
B2 = zeros(length(c2),1);
for j=1:length(c2)
    indices2=c2{j};
    for k=1:length(c2)
        [val2,pos2]=intersect(indices2,c2{k});
        v_overlap2(k)=length(val2);
    end
    neighbour_logical2=v_overlap2>0;
    Number2(j)=sum(neighbour_logical2);
    Area2(j)=sum(A2(neighbour_logical2==1));
    Density2(j)=Number2(j)/Area2(j);
end
av_Density=mean(Density2(~isnan(Density2)));