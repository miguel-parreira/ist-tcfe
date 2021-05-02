close all
clear all
pkg load control
format long

A=23
f=50;
R=100000;
C=100 * 1e-6;
Is=1e-14;
eta=1;
Vt=1e-3;
t=linspace(0,0.2,1000);
w=2*pi*f;
vS=A*sin(w*t);
vO = abs(vS);
vOhr = zeros(1, length(t));
vO = zeros(1, length(t));
von=11.99997/19;
rd=((12.00813-11.99589)/(4.092084e-04-3.957988e-04)/19);



tOFF = 1/w * atan(1*w*R*C)

vOnexp = A*sin(w*tOFF)*exp(-(t-tOFF)/R/C);

figure
for i=1:length(t)
  if (vS(i) > 0)
    vOhr(i) = vS(i);
  else
    vOhr(i) = 0;
  endif
endfor

plot(t, vOhr)
hold

for i=1:length(t)

  if t(i) < tOFF
    vO(i) = vS(i);
  elseif t(i) > tOFF+0.02
    tOFF = tOFF + 0.02;
    vOnexp = A*sin(w*tOFF)*exp(-(t-tOFF)/R/C);
    vO(i) = vS(i);
  elseif vOnexp(i) > vOhr(i)
    vO(i) = vOnexp(i);
  else
    vO(i) = vS(i);
  endif
endfor

plot(t, vO)
title("Output voltage v_o(t)")
xlabel ("t[ms]")
legend("rectified","envelope")
legend('Location','eastoutside')
print ("venvlope.eps", "-depsc");
