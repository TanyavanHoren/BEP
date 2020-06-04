clear all
close all
clc

if generate_new_data==1
    [filenames_circle, filenames_rectangle] = Generate_datasets_loop();
end