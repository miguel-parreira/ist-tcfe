close all
clear all

pkg load symbolic

TxtFile = fopen('data.txt', 'r');
data = dlmread (TxtFile, '\n');
fclose(TxtFile);

R1 = vpa(data(1));
R2 = vpa(data(2));
R3 = vpa(data(3));
R4 = vpa(data(4));
R5 = vpa(data(5));
R6 = vpa(data(6));
R7 = vpa(data(7));
Vs = vpa(data(8));
C = vpa(data(9));
Kb = vpa(data(10));
Kd = vpa(data(11));

PI = vpa(pi);

G1=vpa(1/R1);
G2=vpa(1/R2);
G3=vpa(1/R3);
G4=vpa(1/R4);
G5=vpa(1/R5);
G6=vpa(1/R6);
G7=vpa(1/R7);

syms f real;
Zc = 1/(j*C*2*PI*f);
Gc = 1/Zc;

A1 = [1, 0, 0, 0, 0, 0, 0, 0];
A2 = [-G1, G1+G2+G3, -G2, 0, -G3, 0, 0, 0];
A3 = [0, -Kb-G2, G2, 0, Kb, 0, 0, 0];
A4 = [0, 0, 0, 1, 0, 0, 0, 0];
A5 = [0, -G3, 0, -G4, G4+G3+G5, -G5+Gc, -G7, G7-Gc];
A6 = [0 , -Kb, 0, 0, G5+Kb, -G5+Gc, 0, -Gc];
A7 = [0, 0, 0, G6, 0, 0, -G6-G7, G7];
A8 = [0, 0, 0, -Kd*G6, 1, 0, Kd*G6, -1];

A=[A1; A2; A3; A4; A5; A6; A7; A8];
b = [1; 0; 0; 0; 0; 0; 0; 0];

v=A\b;

printf('\nV6: \n\n');
v(6)
[N1, D1] = numden(v(6));


printf('\nV8: \n\n');
v(8)
[N2, D2] = numden(v(8));

filename=fopen('valores_bode.txt', 'w+');
fprintf(filename, '%s %s %s %s %s %s %s %s' , char(real(N1)), char(imag(N1)), char(real(D1)), char(imag(D1)), char(real(N2)), char(imag(N2)), char(real(D2)), char(imag(D2)));
fclose(filename);
