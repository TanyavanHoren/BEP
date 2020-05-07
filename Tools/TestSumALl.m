mat = ones(1000,1000);

for i=1:50 %ranges
    x(i)=round(rand()*990)+5;
    spot(i).lb_x=x(i)-4;
    spot(i).rb_x=x(i)+4;
    y(i)=round(rand()*990)+5;
    spot(i).lb_y=y(i)-4;
    spot(i).rb_y=y(i)+4;
end
tic
for n=1:500
    for i=1:50
        a(i).mat=mat([spot(i).lb_y:spot(i).rb_y],[spot(i).lb_x:spot(i).rb_x]);
    end
    
    for i=1:50
        spot(i).sum(n)=sum(a(i).mat,'all');
    end
end
t_end = toc