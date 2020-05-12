function rainSTORM_parfor_progress(parfor_progress_norm_factor,N)

if nargin < 2
    N = -1;
end

persistent num_of_calls
w = 50;

if isempty(num_of_calls)
    num_of_calls = 0;
else
    num_of_calls = num_of_calls + 1;
end

if N > 0
    num_of_calls = 0;
    disp(['  0%[>', repmat(' ', 1, w), ']']);
elseif N == 0
    num_of_calls = 0;
    disp([repmat(char(8), 1, (w+9)), char(10), '100%[', repmat('=', 1, w+1), ']']);
else
    percent = min(num_of_calls./parfor_progress_norm_factor*100,99);
    perc = sprintf('%3.0f%%', percent); % 4 characters wide, percentage
    disp([repmat(char(8), 1, (w+9)), char(10), perc, '[', repmat('=', 1, round(percent*w/100)), '>', repmat(' ', 1, w - round(percent*w/100)), ']']);
end