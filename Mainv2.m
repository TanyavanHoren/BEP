clear all
close all
clc

folder = fileparts(which('mainv2.m'));
addpath(genpath(folder)); %add folder to path

%% Modus and display
tic;
set.other.system_choice = 1; %1: spherical particle, 2: nanorod
set.other.visFreq = 100; %visualization made every # frames

%% Read input


%% Predefine

t_end = toc;
disp("Initialisation done" + newline + "Time taken: " + num2str(t_end) + " seconds" + newline)
%% Generate ROIs with binding spots
tic;

t_end = toc;
disp("Generate objects done" + newline + "Time taken: " + num2str(t_end) + " seconds" + newline)
%% Data generation
