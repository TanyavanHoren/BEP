classdef rainSTORM_read_stack < handle
    % rainSTORM_read_stack   Image reading class
    % obj = rainSTORM_read_stack(params) or
    % obj = rainSTORM_read_stack(params, boost_tiff_read) creates a rainSTORM_read_stack object associated with the
    % image filename, it uses tiff read boost if tifflib class is available
    properties %(SetAccess = private, GetAccess = private)
        filename = '';  %Filename with path without extension
        fullfilename = ''; %Full file name with path and extension
        ext = ''; %File extension
        readmethod = '';
        available_readmethods = {}; %Cell array to store the available read method references.
        myImInfo;   %Information about the file
        width = 0;  %The width of the image
        height = 0; %The height of the image
        frameSize = [];
        numofim = 0;%The number of the images in the file
        Profile = [];
        transpose = false;
        boost_tiff_read = false;
    end
    
    %Constructor
    methods
        function obj = rainSTORM_read_stack(varargin)
            % If the constructor called without any argument, then the
            % object would not read any image, but the avaliable methods
            % could be obtained.
            obj.available_readmethods = {'tiff','raw','nd2','dat'};
            if nargin == 0
                return;
            end
            if nargin >= 1
                var = varargin{1};
                [pathstr, name, obj.ext] = fileparts(var.fullfilename);
                obj.filename = [pathstr,filesep,name];
                obj.fullfilename = var.fullfilename;
                obj.readmethod = var.readmethod;
                obj.transpose = var.transpose;
                if nargin == 2
                    obj.boost_tiff_read = varargin{2};
                end
            else
                error('Not enough parameters!')
            end
            
            if exist(obj.fullfilename, 'file') == 2
                switch obj.readmethod
                    case 'tiff'
                        obj.reader_method_tiff();
                    case 'raw'
                        obj.reader_method_raw();
                    case 'nd2'
                        obj.reader_method_nd2();
                    case 'dat'
                        obj.reader_method_dat();
                    otherwise
                        error('Not supported file read method:\n%s', obj.readmethod);
                end
            else
                % File does not exist.
                error('File does not exist:\n%s', obj.fullfilename);
            end
        end % rainSTORM_read_stack
    end
    
    methods
        function filename = getFilename(obj)
            filename = obj.filename;
        end
        function width = getWidth(obj)
            width = obj.width;
        end
        function height = getHeight(obj)
            height = obj.height;
        end
        function type = getReadmethod(obj)
            type = obj.readmethod;
        end
        function type = getAvailable_readmethods(obj)
            type = obj.available_readmethods;
        end
        function info = getInfo(obj)
            info = obj.myImInfo;
        end
        function numofimg = getNumberOfImages(obj)
            numofimg = obj.numofim;
        end
        function frameSize = getFrameSize(obj)
            frameSize = obj.frameSize;
        end
        function disp(obj)
            fprintf(1,'Image name: %s\nImage type: %s\nImage Number: %d\nHeight: %d\nWidth: %d\n',...
                obj.fullfilename,obj.ext,obj.numofim,obj.height,obj.width);
        end
    end
    methods (Access = 'private')
        function reader_method_tiff(obj)
            global rainSTORM_raw_stack;
            warning 'off'
            obj.myImInfo = imfinfo(obj.fullfilename);
            obj.numofim = numel(obj.myImInfo);
            obj.width = obj.myImInfo(1).Width;
            obj.height = obj.myImInfo(1).Height;
            obj.frameSize = [obj.height,obj.width];
            % see http://www.matlabtips.com/how-to-load-tiff-stacks-fast-really-fast/
            if obj.boost_tiff_read
                rainSTORM_raw_stack = zeros(obj.height,obj.width,obj.numofim, 'uint16');
                FileID = tifflib('open',obj.fullfilename,'r');
                rps = tifflib('getField',FileID,Tiff.TagID.RowsPerStrip);
                for i=0:obj.numofim-1
                    tifflib('setDirectory',FileID,i);
                    rps = min(rps,obj.height);
                    for r = 1:rps:obj.height
                        row_inds = r:min(obj.height,r+rps-1);
                        stripNum = tifflib('computeStrip',FileID,r-1);
                        rainSTORM_raw_stack(row_inds,:,i+1) = tifflib('readEncodedStrip',FileID,stripNum-1);
                    end
                end
                tifflib('close',FileID);
            else
                TifLink = Tiff(obj.fullfilename, 'r');
                rainSTORM_raw_stack = zeros(obj.height,obj.width,obj.numofim, 'uint16');
                for lpIm = 1:obj.numofim
                    TifLink.setDirectory(lpIm);
                    rainSTORM_raw_stack(:,:,lpIm) = TifLink.read();
                end
                TifLink.close();
            end
            if obj.transpose
                rainSTORM_raw_stack = permute(rainSTORM_raw_stack,[2 1 3]);
            end
            warning 'on'
        end
        function reader_method_raw(obj)
            global rainSTORM_raw_stack;
            [obj.height,obj.width,obj.numofim] = rainSTORM_xmlread(obj.filename);
            obj.frameSize = [obj.height,obj.width];
            fileID = fopen(obj.fullfilename,'r'); % Open the file for reading
            rainSTORM_raw_stack = zeros(obj.height,obj.width,obj.numofim,'uint16');
            rainSTORM_raw_stack(:) = fread(fileID,Inf,'*uint16');
            fclose(fileID);
            if obj.transpose
                rainSTORM_raw_stack = permute(rainSTORM_raw_stack,[2 1 3]);
            end
        end
        function reader_method_nd2(obj)
            global rainSTORM_raw_stack;
            data = bfopen(obj.fullfilename);
            obj.numofim=size(data{1},1);
            [obj.height,obj.width]=size(data{1}{1});
            obj.frameSize = [obj.height,obj.width];
            
            temp=strsplit(data{2}.get('Global sSpecSettings'),char([13 10]))';
            params.Camera_Type=temp{1}(14:end);
            params.Binning=temp{2}(10:end);
            params.Exposure=str2double(data{2}.get('Global Exposure'));
            Multiplier=sscanf(temp{4},'Multiplier: %g');
            if isempty(Multiplier)
                params.Multiplier=0;
            else
                params.Multiplier=Multiplier;
            end
            params.Readout_Speed=sscanf(temp{5},'Readout Speed: %g MHz');
            params.Conversion_Gain=sscanf(temp{6},'Conversion Gain: %g');
            params.Vertical_Shift_Speed=sscanf(temp{7},'Vertical Shift Speed: %g');
            params.Vertical_Clock_Voltage_Amplitude=sscanf(temp{8},'Vertical Clock Voltage Amplitude: %s');
            params.Trigger_Mode=sscanf(temp{9},'Trigger Mode: %s');
            params.Temperature=sscanf(temp{10},'Temperature: %g');
            params.Time_stamp=data{2}.get('Global TextInfoItem_915/01/201');
            obj.myImInfo.nd2 = params;
            
            rainSTORM_raw_stack=zeros([obj.height obj.width obj.numofim],'uint16');
            for idx_frame = 1:obj.numofim
                rainSTORM_raw_stack(:,:,idx_frame)=data{1}{idx_frame};
            end
            if obj.transpose
                rainSTORM_raw_stack = permute(rainSTORM_raw_stack,[2 1 3]);
            end
        end
        function reader_method_dat(obj)
            global rainSTORM_raw_stack;
            N = dlmread(obj.fullfilename);
            [raw_rows,raw_cols]= size(N);
            rainSTORM_raw_stack=permute(reshape(N',raw_cols,raw_cols,[]),[2 1 3]);
            obj.width = raw_cols;
            obj.frameSize = [obj.width,obj.width];
            obj.height = obj.width;
            obj.numofim = raw_rows ./ raw_cols;
            if obj.transpose
                rainSTORM_raw_stack = permute(rainSTORM_raw_stack,[2 1 3]);
            end
        end
    end
end