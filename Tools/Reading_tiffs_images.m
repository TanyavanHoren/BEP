View TIFF:
im = imread('ROI1frame1.tif');
figure
imshow(im, [0 1000])

FilePath='C:\Users\20174314\OneDrive - TU Eindhoven\_Uni_Backup_Tanya\_Y3Q4\3MN210 - Single molecule microscopy for nanomaterials\Practicum 1\Datasets\Datasets\exc09_DATASET_A\1.tif';
Image = imread(FilePath);%Read in image   
Image = im2double(Image)*65535;%
