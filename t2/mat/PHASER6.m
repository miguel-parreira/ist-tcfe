function out = PHASER6 (q)
  TxtFile = fopen('data.txt', 'r');
  data = dlmread (TxtFile, '\n');
  fclose(TxtFile);

  R1 = data(1);
  R2 = data(2);
  R3 = data(3);
  R4 = data(4);
  R5 = data(5);
  R6 = data(6);
  R7 = data(7);
  Vs = data(8);
  C = data(9);
  Kb = data(10);
  Kd = data(11);

  G1=1/R1;
  G2=1/R2;
  G3=1/R3;
  G4=1/R4;
  G5=1/R5;
  G6=1/R6;
  G7=1/R7;

  w = 2*pi*q;
  Zc = 1/(j*C*w);
  Gc = 1/Zc;

  A1 = [1, 0, 0, 0, 0, 0, 0, 0]
  A2 = [-G1, G1+G2+G3, -G2, 0, -G3, 0, 0, 0]
  A3 = [0, -Kb-G2, G2, 0, Kb, 0, 0, 0]
  A4 = [0, 0, 0, 1, 0, 0, 0, 0]
  A5 = [0, -G3, 0, -G4, G4+G3+G5, -G5+(w*j*C), -G7, G7-(w*j*C)]
  A6 = [0 , -Kb, 0, 0, G5+Kb, -G5+(w*j*C), 0, -(w*j*C)]
  A7 = [0, 0, 0, G6, 0, 0, -G6-G7, G7]
  A8 = [0, 0, 0, -Kd*G6, 1, 0, Kd*G6, -1]

  A=[A1; A2; A3; A4; A5; A6; A7; A8]
  b = [1; 0; 0; 0; 0; 0; 0; 0]

  v=A\b;
  out = v(6);
endfunction
