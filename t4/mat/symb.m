close all
clear all

pkg load symbolic

syms f real;
%frequency response Vo(f)/Vi(f) in log scale with 10 points per decade, from 10Hz to 100MHz
RE1=vpa(100);
PI = vpa(pi);
vi=vpa(1e-2);
ZS=vpa(100);
Zi=1/(j*(1e-3)*2*PI*f)
ZB= vpa(16000);
Zpi1=vpa(499.56);
ZE1=vpa(100);
Zb=1/(j*(1e-3)*2*PI*f)
Zo1=vpa(7793.9);
ZC= vpa(1000);
Zpi2=vpa(1/0.14442);
ZE2=vpa(10);
Zo2= vpa(1/0.022061);
Zo= 1/(j*(0.5e-3)*2*PI*f)
gm1=vpa(0.35772);
gm2=vpa(32.827);



ZSi=ZS+Zi
ZE1b=1/((1/ZE1)+(1/Zb))
ZE2o2=1/((1/ZE2)+(1/Zo2))

GSI=1/ZSi
GB=vpa(1/ZB)
Gpi1=vpa(1/Zpi1)
GE1b=1/ZE1b
Go1=vpa(1/Zo1)
Gc=vpa(1/ZC)
Gpi2=vpa(1/Zpi2)
GE2o2=vpa(1/ZE2o2)
Go=1/Zo
G8=vpa(1/8);


A1 = [1, 0, 0, 0, 0, 0];
A2 = [-GSI, GSI+GB+Gpi1, -Gpi1, 0,0 , 0];
A3 = [0,gm1+Gpi1 ,-gm1-Gpi1-GE1b-Go1 , Go1, 0, 0];
A4 = [0, gm1, -gm1-Go1, Go1+Gc+Gpi2,-Gpi2 , 0];
A5 = [0, 0, 0,Gpi2+gm2 ,-Gpi2-gm2-GE2o2-Go , Go];
A6 = [0 , 0, 0, 0, Go,-Go-G8 ];

A=[A1; A2; A3; A4; A5; A6];
b = [vi; 0; 0; 0; 0; 0];

v=A\b;

printf('\nV6: \n\n');
v(6)
[N1, D1] = numden(v(6));



filename=fopen('valores_bode.txt', 'w+');
fprintf(filename, '%s %s %s %s' , char(real(N1)), char(imag(N1)), char(real(D1)), char(imag(D1)));
fclose(filename);
