close all
clear all

printf("\n\nSYMBOLIC COMPUTATIONS:\n");

pkg load symbolic

syms R1
syms R2
syms R3
syms R4
syms R5
syms R6
syms R7
syms Va
syms Id
syms Kb
syms Kc

one = vpa(1)
zero = vpa(0)

printf("\n\nMetodo das malhas:\n");

A = [R1+R2+R3 , R3, zero; Kb*R3, Kb*R3-one, zero; R4, zero, R4+R6+R7-Kc]

b = [Va; zero; zero]

printf("\n\nSolution:\n");

A\b

printf("\n\nMetodo dos nós:\n");

A1 = [one, zero, zero, -one, zero, zero, zero, zero]
A2 = [R1 , -R1-R2-R3, R2, zero, R3, zero, zero, zero]
A3 = [zero, Kb+R2, -R2, zero, -Kb, zero, zero, zero]
A4 = [-R1, R1, zero, -R6-R4, R4, zero, R6, zero]
A5 = [zero, zero, zero, Kc*R6, -one, zero, -Kc*R6, one]
A6 = [zero , -Kb, zero, zero, R5+Kb, -R5, zero, zero]
A7 = [zero, zero, zero, R6, zero, zero, -R6-R7, R7]
A8 = [zero, zero, zero, zero, zero, zero, zero, one]

A=[A1; A2; A3; A4; A5; A6; A7; A8]


b = [Va; zero; zero; zero; zero; -Id; zero; zero]

printf("\n\nSolution:\n");

A\b


%printf("\n\nNatural solution:\n");
%syms A
%syms wn

%vi(t) = 0 %no excitation
%i_n(t) = C*diff(vo_n, t)


%printf("\n\n Natural solution is of the form");
%vo_n(t) = A*exp(wn*t)

%R*i_n(t)+vo_n(t) == 0

%R*C*wn*vo_n(t)+vo_n(t) == 0

%R*C*wn+1==0

%solve(ans, wn)

printf("\n\nNUMERIC COMPUTATIONS:\n");
format long

R1 = 1003.77057233
R2 = 2069.4578747
R3 = 3114.94140037
R4 = 4196.64806451
R5 = 3096.43940177
R6 = 2099.19602758
R7 = 1006.20732709
Va = 5.03993052267
Id = 0.0010174579624
Kb = 7.16450079517
Kc = 8.22132225609

printf("\n\nMetodo das malhas:\n");

A = [R1+R2+R3 , R3, 0; Kb*R3, Kb*R3-1, 0; R4, 0, R4+R6+R7-Kc]
b = [Va; 0; 0]

printf("\n\nSolution:\n");
A\b

printf("\n\nMetodo dos nós:\n");

A1 = [1, 0, 0, -1, 0, 0, 0, 0]
A2 = [R1 , -R1-R2-R3, R2, 0, R3, 0, 0, 0]
A3 = [0, Kb+R2, -R2, 0, -Kb, 0, 0, 0]
A4 = [-R1, R1, 0, -R6-R4, R4, 0, R6, 0]
A5 = [0, 0, 0, Kc*R6, -1, 0, -Kc*R6, 1]
A6 = [0 , -Kb, 0, 0, R5+Kb, -R5, 0, 0]
A7 = [0, 0, 0, R6, 0, 0, -R6-R7, R7]
A8 = [0, 0, 0, 0, 0, 0, 0, 1]

A=[A1; A2; A3; A4; A5; A6; A7; A8]
b = [Va; 0; 0; 0; 0; -Id; 0; 0]

printf("\n\nSolution:\n");
A\b


%R=1e3 %Ohm
%C=100e-9 %F

%f = 1000 %Hz
%w = 2*pi*f; %rad/s

%time axis: 0 to 10ms with 1us steps
%t=0:1e-6:10e-3; %s

%Zc = 1/(j*w*C)
%Cgain = Zc/(R+Zc)
%Gain = abs(Cgain)
%Phase = angle(Cgain)

%vi = 1*cos(w*t);
%vo = Gain*cos(w*t+Phase);

%hf = figure ();
%plot (t*1000, vi, "g");
%hold on;
%plot (t*1000, vo, "b");

%xlabel ("t[ms]");
%ylabel ("vi(t), vo(t) [V]");
%print (hf, "forced.eps", "-depsc");
