% A = ones(10000,10000);
% T = 1030;
% B = zeros(10000,10000);
% % %strategy 1: 13.581 s
% % for i = 1:10000
% %     for j = 1:10000
% %         if A(i,j)>T
% %             B(i,j)=1;
% %         end
% %     end
% % end
% %         
% % %strategy 2: 1.446 s
% for i=1:10000
%    if sum(A(i,:))>100*T;
%        for j=1:10000
%            if A(i,j)>T
%                B(i,j)=1;
%            end
%        end
%    end      
% end

for i=1:100
    A(i)=lognrnd(4,0.7);
end


