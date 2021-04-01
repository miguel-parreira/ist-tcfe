close all
clear all

printf("\n\nNUMERIC COMPUTATIONS:\n");
format long

TxtFile = fopen("data.txt", "r");
data = dlmread (TxtFile, '\n')
fclose(TxtFile);

R1 = data(1)
R2 = data(2)
R3 = data(3)
R4 = data(4)
R5 = data(5)
R6 = data(6)
R7 = data(7)
Vs = data(8)
C = data(9)
Kb = data(10)
Kd = data(11)

printf("\n\nPonto 1 - metodo dos nós:\n");
