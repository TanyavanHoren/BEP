size = 10000000;
mean = 1000;
test = poissrnd(mean,[1,size]);

for i = 1:size
    if test(i)>mean
        test(i)=1;
    else
        test(i) =0;
    end
end

% test(test>mean)=1;
% test(test<mean)=0;