% % num= ana.ROI.number;
% temp = zeros(num);
% bound = zeros(num,4);

% for i=1:num
%     bound(i,1) = ana.ROI.ROI(i).lower_bound_x;
%     bound(i,2) =     ana.ROI.ROI(i).upper_bound_x;
%     bound(i,3) =     ana.ROI.ROI(i).lower_bound_y;
%     bound(i,4) =     ana.ROI.ROI(i).upper_bound_y;
% end
% % 
% parfor i=1:ana.ROI.number 
%     A = frame([ana.ROI.ROI(i).lower_bound_y:ana.ROI.ROI(i).upper_bound_y], [ana.ROI.ROI(i).lower_bound_x:ana.ROI.ROI(i).upper_bound_x]); %create submatrix A containing the counts in the ROI
%     temp(i) = sum(A, 'all'); %sum over all elements of submatrix A
% end

% parfor i=1:num 
%     A = frame([bound(i,3):bound(i,4)], [bound(i,1):bound(i,2)]); %create submatrix A containing the counts in the ROI
%     temp(i) = sum(A, 'all'); %sum over all elements of submatrix A
% end

% for i=1:num
%     ana.ROI.ROI(i).timetrace(n_frame)= temp(i);
% end

