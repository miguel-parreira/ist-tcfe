close all
clear all

pkg load control

printf('\n\nNUMERIC COMPUTATIONS:\n');
format long

TxtFile = fopen('data.txt', 'r');
data = dlmread (TxtFile, '\n')
fclose(TxtFile);

R1 = data(1) * 1e3
R2 = data(2) * 1e3
R3 = data(3) * 1e3
R4 = data(4) * 1e3
R5 = data(5) * 1e3
R6 = data(6) * 1e3
R7 = data(7) * 1e3
Vs = data(8)
C = data(9) * 1e-6
Kb = data(10) * 1e-3
Kd = data(11) * 1e3

printf('\n\n---->Ponto 1 - metodo dos nós:\n');

G1=1/R1;
G2=1/R2;
G3=1/R3;
G4=1/R4;
G5=1/R5;
G6=1/R6;
G7=1/R7;

A1 = [1, 0, 0, 0, 0, 0, 0, 0];
A2 = [-G1, G1+G2+G3, -G2, 0, -G3, 0, 0, 0];
A3 = [0, -Kb-G2, G2, 0, Kb, 0, 0, 0];
A4 = [0, 0, 0, 1, 0, 0, 0, 0];
A5 = [0, -G3, 0, -G4, G4+G3+G5, -G5, -G7, G7];
A6 = [0 , -Kb, 0, 0, G5+Kb, -G5, 0, 0];
A7 = [0, 0, 0, G6, 0, 0, -G6-G7, G7];
A8 = [0, 0, 0, -Kd*G6, 1, 0, Kd*G6, -1];
A=[A1; A2; A3; A4; A5; A6; A7; A8];
b = [Vs; 0; 0; 0; 0; 0; 0; 0];

printf('\n\nSolution: (v1-v8)\n');
v1=A\b

tabela1=fopen('tabela1.tex', 'w+');
fprintf(tabela1, ' \\begin{table}[h] \n \\label{tab:tables} \n \\begin{center} \n \\begin{tabular}{|c|c|} \n  \\hline \n   Node Voltage & Value \\hspace{1mm}(V)\\\\ \n  \\hline \n  $V_{1}$ & %.15f   \\\\ \n   \\hline \n  $V_{2}$ & %.15f \\\\ \n   \\hline \n  $V_{3}$ & %.15f \\\\ \n   \\hline \n  $V_{4}$ & %.15f \\\\ \n   \\hline \n  $V_{5}$ & %.15f \\\\ \n   \\hline \n  $V_{6}$ & %.15f \\\\ \n   \\hline \n  $V_{7}$ & %.15f \\\\ \n   \\hline \n  $V_{8}$ &  %.15f \\\\ \n  \\hline \n \\end{tabular} \n \\caption{Solutions to Node Analysis Method} \n \\label{table:tab1} \n \\end{center} \n \\end{table} \n ' , v1(1), v1(2), v1(3), v1(4), v1(5), v1(6), v1(7), v1(8));
fclose(tabela1);

printf('\n\nCorrentes:\n');
I1 = G1*(v1(1)-v1(2))*1e3
I2 = G2*(v1(3)-v1(2))*1e3
I3 = G3*(v1(2)-v1(5))*1e3
I4 = G4*(v1(5)-v1(4))*1e3
I5 = G5*(v1(5)-v1(6))*1e3
Id = G6*(v1(4)-v1(7))*1e3
I7 = G7*(v1(7)-v1(8))*1e3
Ib = Kb*(v1(2)-v1(5))*1e3
Ivd = I7
Ic = 0

tabela2=fopen('tabela2.tex', 'w+');
fprintf(tabela2, ' \\begin{table}[h] \n \\label{tab:tables} \n \\begin{center} \n \\begin{tabular}{|c|c|} \n  \\hline \n   Branch Current  & Value \\hspace{1mm}(mA)\\\\ \n  \\hline \n  $I_{1}$ & %.15f   \\\\ \n   \\hline \n  $I_{2}$ & %.15f \\\\ \n   \\hline \n  $I_{3}$ & %.15f \\\\ \n   \\hline \n  $I_{4}$ & %.15f \\\\ \n   \\hline \n  $I_{5}$ & %.15f \\\\ \n   \\hline \n  $I_{7}$ & %.15f \\\\ \n   \\hline \n  $I_{vd}$ & %.15f \\\\ \n   \\hline \n  $I_{b}$ &  %.15f \\\\ \n \\hline \n  $I_{c}$ &  %.15f \\\\ \n  \\hline \n \\end{tabular} \n \\caption{Solutions to Node Analysis Method} \n \\label{table:tab2} \n \\end{center} \n \\end{table} \n ' , I1, I2, I3, I4, I5, I7, Ivd, Ib, Ic);
fclose(tabela2);


printf('\n\n---->Ponto 2 - Resistencia Equivalente:\n');
Vx = v1(8) - v1(6);
A1 = [1, 0, 0, 0, 0, 0, 0, 0, 0];
A2 = [-G1, G1+G2+G3, -G2, 0, -G3, 0, 0, 0, 0];
A3 = [0, -Kb-G2, G2, 0, Kb, 0, 0, 0, 0];
A4 = [0, 0, 0, 1, 0, 0, 0, 0, 0];
A5 = [0, -G3, 0, -G4, G4+G3+G5, -G5, -G7, G7, -1];
A6 = [0 , -Kb, 0, 0, G5+Kb, -G5, 0, 0, -1];
A7 = [0, 0, 0, G6, 0, 0, -G6-G7, G7, 0];
A8 = [0, 0, 0, -Kd*G6, 1, 0, Kd*G6, -1, 0];
A9 = [0, 0, 0, 0, 0, -1, 0, 1, 0];

A=[A1; A2; A3; A4; A5; A6; A7; A8; A9];
b = [0; 0; 0; 0; 0; 0; 0; 0; Vx];

printf('\n\nSolution: (v1-v8,Ix)\n');
v2=A\b
Req = (v2(8)-v2(6))/v2(9)
Tau = Req*C %Ohm*F

tabela3=fopen('tabela3.tex', 'w+');
fprintf(tabela3, ' \\begin{table}[h] \n \\label{tab:tables} \n \\begin{center} \n \\begin{tabular}{|c|c|} \n  \\hline \n   Variables & Value \\hspace{1mm}(V / $\\Omega$ / $\\Omega * F$)\\\\ \n  \\hline \n  $V_{1}$ & %.15f   \\\\ \n   \\hline \n  $V_{2}$ & %.15f \\\\ \n   \\hline \n  $V_{3}$ & %.15f \\\\ \n   \\hline \n  $V_{4}$ & %.15f \\\\ \n   \\hline \n  $V_{5}$ & %.15f \\\\ \n   \\hline \n  $V_{6}$ & %.15f \\\\ \n   \\hline \n  $V_{7}$ & %.15f \\\\ \n   \\hline \n  $V_{8}$ &  %.15f \\\\ \n \\hline \n  $I_{x}$ &  %.15f \\\\ \n \\hline \n  $R_{eq}$ &  %.15f \\\\ \n \\hline \n  $\\tau$ &  %.15f \\\\ \n \\hline \n \\end{tabular} \n \\caption{Solutions to Node Analysis Method} \n \\label{table:tab3} \n \\end{center} \n \\end{table} \n ' , v2(1), v2(2), v2(3), v2(4), v2(5), v2(6), v2(7), v2(8), v2(9), Req, Tau);
fclose(tabela3);



printf('\n\n---->Ponto 3 - V6 natural:\n');
%time axis: 0 to 20ms with 1us steps
t=0:1e-6:20e-3; %s

v6_n = v2(6)*exp(-t/Tau);
v8_n = v2(8)*exp(-t/Tau);

f = figure ();
plot (t*1000, v6_n, 'r');

xlabel ('t[ms]');
ylabel ('v6_nu [V]');
print (f, 'v6_natural.eps', '-depsc');

printf('\n\n---->Ponto 4 - V6 forçada:\n');
w = 2*pi*1000;
Zc = 1/(j*C*w);
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

printf('\n\nSolution: (v1-v8)\n');
v3=A\b

tabela4=fopen('tabela4.tex', 'w+');
fprintf(tabela4, ' \\begin{table}[h] \n \\label{tab:tables} \n \\begin{center} \n \\begin{tabular}{|c|c|} \n  \\hline \n   Phasor &  \\\\ \n  \\hline \n  $V_{1}$ & %.6f%+fj   \\\\ \n   \\hline \n  $V_{2}$ & %.6f%+fj \\\\ \n   \\hline \n  $V_{3}$ & %.6f%+fj \\\\ \n   \\hline \n  $V_{4}$ & %.6f%+fj \\\\ \n   \\hline \n  $V_{5}$ & %.6f%+fj \\\\ \n   \\hline \n  $V_{6}$ & %.6f%+fj \\\\ \n   \\hline \n  $V_{7}$ & %.6f%+fj \\\\ \n   \\hline \n  $V_{8}$ &  %.6f%+fj \\\\ \n  \\hline \n \\end{tabular} \n \\caption{Solutions to Node Analysis Method} \n \\label{table:tab4} \n \\end{center} \n \\end{table} \n ' , real(v3(1)), imag(v3(1)), real(v3(2)), imag(v3(2)), real(v3(3)), imag(v3(3)), real(v3(4)), imag(v3(4)), real(v3(5)), imag(v3(5)), real(v3(6)), imag(v3(6)), real(v3(7)), imag(v3(7)), real(v3(8)), imag(v3(8)));
fclose(tabela4);


Gain6 = abs(v3(6));
Phase6 = angle(v3(6));

v6_f = Gain6*sin(w*t+Phase6);

f2 = figure ();
plot (t*1000, v6_f, 'r');

xlabel ('t[ms]');
ylabel ('v6_f(t) [V]');
print (f2, 'v6_forçada.eps', '-depsc');

printf('\n\n---->Ponto 5 - Solução final:\n');
%time axis: -5 to 20ms with 1us steps
t=-5e-3:1e-6:20e-3; %s

Gain8 = abs(v3(8))
Phase8 = angle(v3(8))
v8_f = Gain8*sin(w*t+Phase8);

v6 = v2(6)*exp(-t/Tau) + Gain6*sin(w*t+Phase6);
v8 = v2(8)*exp(-t/Tau) + Gain8*sin(w*t+Phase8);

phase1 = t<0; phase2 = t>=0;
V6(phase1) = v1(6);
V6(phase2) = v2(6)*exp(-t(phase2)/Tau) + Gain6*sin(w*t(phase2)+Phase6);

vs(phase1) = Vs;
vs(phase2) = sin(w*t(phase2));

f3 = figure ();
plot (t*1000, V6, 'r');
hold on
plot (t*1000, vs, 'm');

xlabel ('t[ms]');
ylabel ('v6(t), vs(t) [V]');
print (f3, 'v6.eps', '-depsc');

printf('\n\n---->Ponto 6 - Estudo frequência:\n');
F=logspace(-1, 6, 200);

TxtFile = fopen('valores_bode.txt', 'r');
line = fgetl(TxtFile);
data3 = sscanf(line, '%f %f*f');
fclose(TxtFile);

numer6 = [data3(2), data3(1)];
denom6 = [data3(4), data3(3)];

v_6 = tf(numer6, denom6);

numers = [0, 1];
denoms = [0, 1];

v_s = tf(numers, denoms);

numer8 = [data3(6), data3(5)];
denom8 = [data3(8), data3(7)];

v_8 = tf(numer8, denom8);

v_c = v_6 - v_8;

f5 = figure();
bode(v_s, v_6, v_c, F)

xlabel ('log(f) [Hz]');
print (f5, 'bode.eps', '-depsc');
