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


function f = f(vD,vS,R)
Is=1e-14;
VT=25e-3;
f = vD+R*Is * (exp(vD/VT/19)-1) - vS;
endfunction

function fd = fd(vD,R)
Is=1e-14;
VT=25e-3;
fd = 1 + R*Is/19/VT * (exp(vD/VT/19)-1);
endfunction

function vD_root = solve_vD (vS, R)
  delta = 1e-6;
  x_next = 0.65;

  do
    x=x_next;
    x_next = x  - f(x, vS, R)/fd(x, R);
  until (abs(x_next-x) < delta)

  vD_root = x_next;
endfunction


t1=linspace(0.05,0.2,1000);
R1=25.4055 * 1e3;

for i=1:length(t)
  vD = solve_vD  (vO, R1);
endfor


for i=1:(length(t)/2)
  vaux(i)= vD(i+(length(t)/2)) ;
endfor

maxvd=max (vD)
minvd=min (vaux)
AVERAGE = mean(vaux)
ripple=maxvd-minvd


figure
plot(t1, vD)
hold on
plot(t, AVERAGE)
title("Output voltage v4")
ylim ([minvd-0.002, maxvd+0.002]);
xlim ([0.07, 0.2]);
xlabel ("t[ms]")
ylabel ("v4[V]")
legend("v4","AVERAGE ")
legend('Location','eastoutside')
print ("vripple.eps", "-depsc");

figure
plot(t, vO)
hold on
plot(t, vD)
title("Envelope (v3) and Output voltage (v4)")
ylabel ("v[V]")
xlabel ("t[ms]")
legend("v3","v4")
legend('Location','eastoutside')
print ("venvlope.eps", "-depsc");
