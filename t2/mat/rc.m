close all
clear all

TxtFile = dlmread('data.txt');
save('data.mat',TxtFile);

printf("\n\nNUMERIC COMPUTATIONS:\n");
format long

load data.mat

printf("\n %f \n", R1);
