function settings = create_standard_settings(set)
settings=[];
settings.Thresh = struct(...
    'val',(set.bg.mu+sqrt(set.bg.mu)*set.ana.std_factor),... %not considered maximum if below noise 
    'text','ROI Candidate Threshold',...
    'tooltip','Threshold to filter out ROI candidates with low signal. [Raw Brightness, (sum of 9 pix val)]',...
    'type','number');
settings.allowSig = struct(...
    'val',[0.5 3+1],...
    'text','Allowed Sigma [pix]',...
    'tooltip','Stop ROI fitting if iteration goes out of this range [min max]. Check: [0.5 (Radius of ROI+1)] [Raw Pixel]',...
    'type','number');
settings.allowX = struct(...
    'val',10,...
    'text','Allowed  Distance [pix]',...
    'tooltip','Stop ROI fitting if iteration goes further than this value. [Raw Pixel]',...
    'type','number');
settings.initSig = struct(...
    'val',set.mic.wavelength/(2*set.mic.NA*sqrt(8*log(2)))/set.mic.pixelsize,...%standard deviation calculated
    'text','Initial guess of PSF Sigma [pix]',...
    'tooltip','The initial sigma value of PSF fitting. [Raw Pixel]',...
    'type','number');
settings.maxIts = struct(...
    'val',set.ana.iterations,...
    'text','Maximum Iterations',...
    'tooltip','The maximum number of iteretions of ROI fitting. [-]',...
    'type','number');
settings.prevSF = struct(...
    'val',5,...
    'text','Preview Scale Factor [int]',...
    'tooltip','Scale factor to render sum image, to have the same size as the super resolved image. [integer]',...
    'type','number');
settings.rad = struct(...
    'val',3,... %3 or 4 for about 100 nm
    'text','Radius of ROI [pix]',...
    'tooltip','''Radius of ROI'' = 3 means that the area of interest for each spot is a 7x7 area. [Raw Pixel]',...
    'type','number');
settings.tol = struct(...
    'val',0.2,...
    'text','Tolerance [-]',...
    'tooltip','Flag the fit as acceptable and save the fit result if the residue is below this value. [-]',...
    'type','number');
settings.mintol = struct(...
    'val',0.005,...
    'text','Tolerance [-]',...
    'tooltip','Flag the fit as done and save the fit result if the residue is below this value. [-]',...
    'type','number');
end

