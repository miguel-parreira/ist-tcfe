close all
clear all
pkg load control
format long
function xdot = f (x, t)
  a=pi;
  R=100000;
  C=100 * 1e-6;
  Is=1e-14;
  eta=1;
  Vt=1e-3;
  dV1=-2*a*50*23*cos(2*a*50*t);
  V1=23*sin(2*a*50*t);

  xdot=(1/(R*C))*(-x-R*Is*(exp(x/(7*eta*Vt))-1)+ R*C*dV1+V1);

endfunction

lsode_options("integration method", "non-stiff")

f(1,2)
x0=0;
t=linspace(0,0.6,1000);
y=lsode("f",x0,t)

hf = figure ();
plot (t, y, "g");
xlabel ("t[ms]");
ylabel ("vi(t), vo(t) [V]");
print (hf, "forced.eps", "-depsc");
