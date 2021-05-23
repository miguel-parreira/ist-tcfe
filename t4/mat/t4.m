%gain stage

VT=25e-3;
BFN=178.7;
VAFN=69.7;
RE1=100;
RC1=400;
RB1=74500;
RB2=20000;
VBEON=0.7;
VCC=12;
RS=100;

RB=1/(1/RB1+1/RB2)
VEQ=RB2/(RB1+RB2)*VCC
IB1=(VEQ-VBEON)/(RB+(1+BFN)*RE1)
IC1=BFN*IB1
IE1=(1+BFN)*IB1
VE1=RE1*IE1
VO1=VCC-RC1*IC1
VCE=VO1-VE1

tabela1=fopen('tabela1.tex', 'w+');
fprintf(tabela1, ' \\begin{table}[h] \n \\label{tab:tables} \n \\begin{center} \n \\begin{tabular}{|c|c|} \n  \\hline \n   Operating Point & Value\\hspace{1mm}(V/A)\\\\ \n  \\hline \n  $I_{B1}$ & %.15f   \\\\ \n   \\hline \n  $I_{C1}$ & %.15f \\\\ \n   \\hline \n  $I_{E1}$ & %.15f \\\\ \n   \\hline \n  $V_{E1}$ & %.15f \\\\ \n   \\hline \n  $V_{O1}$ & %.15f \\\\ \n   \\hline \n  $V_{CE}$ & %.15f \\\\ \n   \\hline \n  \\end{tabular} \n \\caption{Solutions to Node Analysis Method} \n \\label{table:tab1} \n \\end{center} \n \\end{table} \n ' , IB1, IC1, IE1, VE1, VO1, VCE);
fclose(tabela1);




gm1=IC1/VT
rpi1=BFN/gm1
ro1=VAFN/IC1

RSB=RB*RS/(RB+RS)

AV1 = RSB/RS * RC1*(RE1-gm1*rpi1*ro1)/((ro1+RC1+RE1)*(RSB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)
AVI_DB = 20*log10(abs(AV1))
AV1simple = RB/(RB+RS) * gm1*RC1/(1+gm1*RE1)
AVIsimple_DB = 20*log10(abs(AV1simple))

RE1=0
AV1 = RSB/RS * RC1*(RE1-gm1*rpi1*ro1)/((ro1+RC1+RE1)*(RSB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)
AVI_DB = 20*log10(abs(AV1))
AV1simple =  - RSB/RS * gm1*RC1/(1+gm1*RE1)
AVIsimple_DB = 20*log10(abs(AV1simple))

RE1=100
ZI1 = 1/(1/RB+1/(((ro1+RC1+RE1)*(rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)/(ro1+RC1+RE1)))
ZX = ro1*((RSB+rpi1)*RE1/(RSB+rpi1+RE1))/(1/(1/ro1+1/(rpi1+RSB)+1/RE1+gm1*rpi1/(rpi1+RSB)))
ZX = ro1*(   1/RE1+1/(rpi1+RSB)+1/ro1+gm1*rpi1/(rpi1+RSB)  )/(   1/RE1+1/(rpi1+RSB) )
ZO1 = 1/(1/ZX+1/RC1)

RE1=0
ZI1 = 1/(1/RB+1/(((ro1+RC1+RE1)*(rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)/(ro1+RC1+RE1)))
ZO1 = 1/(1/ro1+1/RC1)

%ouput stage
BFP = 227.3;
VAFP = 37.2;
RE2 = 40;
VEBON = 0.7;
VI2 = VO1
IE2 = (VCC-VEBON-VI2)/RE2
IC2 =( BFP/(BFP+1))*IE2
VO2 = VCC - RE2*IE2

tabela2=fopen('tabela2.tex', 'w+');
fprintf(tabela2, ' \\begin{table}[h] \n \\label{tab:tables} \n \\begin{center} \n \\begin{tabular}{|c|c|} \n  \\hline \n   Operating Point  & Value \\hspace{1mm}(V/A)\\\\ \n  \\hline \n  $V_{I2}$ & %.15f   \\\\ \n   \\hline \n  $I_{E2}$ & %.15f \\\\ \n   \\hline \n  $I_{C2}$ & %.15f \\\\ \n   \\hline \n  $V_{E2}$ & %.15f \\\\ \n   \\hline \n   \\end{tabular} \n \\caption{Solutions to Node Analysis Method} \n \\label{table:tab2} \n \\end{center} \n \\end{table} \n ' , VI2, IE2, IC2, VO2);
fclose(tabela2);

gm2 = IC2/VT
go2 = IC2/VAFP
gpi2 = gm2/BFP
ge2 = 1/RE2

AV2 = gm2/(gm2+gpi2+go2+ge2)
ZI2 = (gm2+gpi2+go2+ge2)/gpi2/(gpi2+go2+ge2)
ZO2 = 1/(gm2+gpi2+go2+ge2)


%total
gB = 1/((1/gpi2)+ZO1)
AV = (gB+gm2/gpi2*gB)/(gB+ge2+go2+gm2/gpi2*gB)*AV1
AV_DB = 20*log10(abs(AV))
ZI=ZI1
ZO=1/(go2+gm2/gpi2*gB+ge2+gB)



%function log
function gain = funcf(f)
  RE1= 100;
  PI =  pi;
  vi= 1e-2;
  ZS= 100;
  Zi=1/(j*(1e-3)*2*PI*f);
  ZB=  15767.19577;
  Zpi1= 458.46;
  ZE1= 100;
  Zb=1/(j*(1e-3)*2*PI*f);
  Zo1= 7152.8;
  ZC=  400;
  Zpi2= 1/0.014007;
  ZE2= 40;
  Zo2=  1/0.0021396;
  Zo= 1/(j*(0.5e-3)*2*PI*f);
  gm1= 0.38978;
  gm2= 3.1838;




  ZE1b=1/((1/ZE1)+(1/Zb));
  ZE2o2=1/((1/ZE2)+(1/Zo2));

  GI=1/Zi;
  GS= 1/ZS;
  GB= 1/ZB;
  Gpi1= 1/Zpi1;
  GE1b=1/ZE1b;
  Go1= 1/Zo1;
  Gc= 1/ZC;
  Gpi2= 1/Zpi2;
  GE2o2= 1/ZE2o2;
  Go=1/Zo;
  G8= 1/8;


  A1 = [1, 0, 0, 0, 0, 0,0];
  A2 = [0, GI+GB+Gpi1, -Gpi1, 0,0 , 0,-GI];
  A3 = [0,gm1+Gpi1 ,-gm1-Gpi1-GE1b-Go1 , Go1, 0, 0,0];
  A4 = [0, gm1, -gm1-Go1, Go1+Gc+Gpi2,-Gpi2 , 0,0];
  A5 = [0, 0, 0,Gpi2+gm2 ,-Gpi2-gm2-GE2o2-Go , Go,0];
  A6 = [0 , 0, 0, 0, Go,-Go-G8,0 ];
  A7 = [ -GS, -GI, 0, 0,0 , 0, GS+GI];

  A=[A1; A2; A3; A4; A5; A6; A7];
  b = [vi; 0; 0; 0; 0; 0; 0];

  v=A\b;

  gain=20*log10(abs(v(6))/vi);
  %gain=abs(v(6));
endfunction

function [y] = func(x)
  for i = 1:70
    y(i)=funcf(x(i));
  end
endfunction




F=logspace(1, 8, 70);
f3 = figure ();
semilogx(F,func(F))
%fplot (funcf(F), 'r');
xlabel ('f[Hz]');
ylabel ('Gain');
print (f3, 'gain.eps', '-depsc');
