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

printf("\n\n---->Ponto 1 - metodo dos nós:\n");

G1=1/R1
G2=1/R2
G3=1/R3
G4=1/R4
G5=1/R5
G6=1/R6
G7=1/R7

A1 = [1, 0, 0, 0, 0, 0, 0, 0]
A2 = [-G1, G1+G2+G3, -G2, 0, -G3, 0, 0, 0]
A3 = [0, -Kb-G2, G2, 0, Kb, 0, 0, 0]
A4 = [0, 0, 0, 1, 0, 0, 0, 0]
A5 = [0, -G3, 0, -G4, G4+G3+G5, -G5, -G7, G7]
A6 = [0 , -Kb, 0, 0, G5+Kb, -G5, 0, 0]
A7 = [0, 0, 0, G6, 0, 0, -G6-G7, G7]
A8 = [0, 0, 0, -Kd*G6, 1, 0, Kd*G6, -1]

A=[A1; A2; A3; A4; A5; A6; A7; A8]
b = [Vs; 0; 0; 0; 0; 0; 0; 0]

printf("\n\nSolution: (v1-v8)\n");
v1=A\b

printf("\n\nCorrentes:\n");
I1 = G1*(v1(1)-v1(2))*1e-3
I2 = G2*(v1(3)-v1(2))*1e-3
I3 = G3*(v1(2)-v1(5))*1e-3
I4 = G4*(v1(5)-v1(4))*1e-3
I5 = G5*(v1(5)-v1(6))*1e-3
Id = G6*(v1(4)-v1(7))*1e-3
I7 = G7*(v1(7)-v1(8))*1e-3
Ib = Kb*(v1(2)-v1(5))*1e-3
Ivd = I7
Ic = 0

printf("\n\n---->Ponto 2 - Resistencia Equivalente:\n");
Vx = v1(8) - v1(6)
A1 = [1, 0, 0, 0, 0, 0, 0, 0, 0]
A2 = [-G1, G1+G2+G3, -G2, 0, -G3, 0, 0, 0, 0]
A3 = [0, -Kb-G2, G2, 0, Kb, 0, 0, 0, 0]
A4 = [0, 0, 0, 1, 0, 0, 0, 0, 0]
A5 = [0, -G3, 0, -G4, G4+G3+G5, -G5, -G7, G7, -1]
A6 = [0 , -Kb, 0, 0, G5+Kb, -G5, 0, 0, -1]
A7 = [0, 0, 0, G6, 0, 0, -G6-G7, G7, 0]
A8 = [0, 0, 0, -Kd*G6, 1, 0, Kd*G6, -1, 0]
A9 = [0, 0, 0, 0, 0, -1, 0, 1, 0]

A=[A1; A2; A3; A4; A5; A6; A7; A8; A9]
b = [0; 0; 0; 0; 0; 0; 0; 0; Vx]

printf("\n\nSolution: (v1-v8,Ix)\n");
v2=A\b
Req = (v2(8)-v2(6))/v2(9)
Tau = Req*1000*C*1e-6 %Ohm*F

printf("\n\n---->Ponto 3 - V6 natural:\n");
%time axis: 0 to 20ms with 1us steps
t=0:1e-6:20e-3; %s

v6_n = v2(6)*exp(-t/Tau);
v8_n = v2(8)*exp(-t/Tau);

f = figure ();
plot (t*1000, v6_n, "g");

xlabel ("t[ms]");
ylabel ("v6_nu [V]");
print (f, "v6_natural.eps", "-depsc");

printf("\n\n---->Ponto 4 - V6 forçada:\n");
w = 2*pi*1000
Zc = 1/(j*C*w)
Gc = 1/Zc

A1 = [1, 0, 0, 0, 0, 0, 0, 0]
A2 = [-G1, G1+G2+G3, -G2, 0, -G3, 0, 0, 0]
A3 = [0, -Kb-G2, G2, 0, Kb, 0, 0, 0]
A4 = [0, 0, 0, 1, 0, 0, 0, 0]
A5 = [0, -G3, 0, -G4, G4+G3+G5, -G5+Gc, -G7, G7-Gc]
A6 = [0 , -Kb, 0, 0, G5+Kb, -G5+Gc, 0, -Gc]
A7 = [0, 0, 0, G6, 0, 0, -G6-G7, G7]
A8 = [0, 0, 0, -Kd*G6, 1, 0, Kd*G6, -1]

A=[A1; A2; A3; A4; A5; A6; A7; A8]
b = [1; 0; 0; 0; 0; 0; 0; 0]

printf("\n\nSolution: (v1-v8)\n");
v3=A\b

Gain6 = abs(v3(6))
Phase6 = angle(v3(6))

v6_f = Gain6*sin(w*t+Phase6);

f2 = figure ();
plot (t*1000, v6_f, "g");

xlabel ("t[ms]");
ylabel ("v6_f(t) [V]");
print (f2, "v6_forçada.eps", "-depsc");

printf("\n\n---->Ponto 5 - Solução final:\n");
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
plot (t*1000, V6, "g");
hold on
plot (t*1000, vs, "m");

xlabel ("t[ms]");
ylabel ("v6(t), vs(t) [V]");
print (f3, "v6.eps", "-depsc");

printf("\n\n---->Ponto 6 - Estudo frequência:\n");
w=0:1:1e6;
