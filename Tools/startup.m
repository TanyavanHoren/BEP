function env = startup()

global env;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Global parameters
v = ver;
for k=1:length(v)
    if strfind(v(k).Name, 'Parallel Computing Toolbox')
        env.parCompTool = str2num((sprintf( v(k).Version)));
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Start matlabpool if there is Parallel Computing Toolbox for R2014a or 
% greater and there is no active matlabpool.
if (env.parCompTool >= 6.4000) && isempty(gcp('nocreate'))
    par_pool_data = gcp;
    env.parCompTool_NumWorkers = par_pool_data.NumWorkers;
elseif ~isempty(gcp('nocreate'))
    disp('Parallel pool already running');
else
    disp('Parallel Computing Disabled');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

