Tch1=0.3;Tch2=0.17;
Tg1=0.1;Tg2=0.4;
R1=0.05;R2=0.05;
D1=1;D2=1.5;
M1=10;M2=12;
k1=.5;k2=0.5;
B1=(D1+(2/R1));B2=(D2+(4/R2));
Kp1=1/D1;Kp2=1/D2;
Tp1=M1/D1;Tp2=M2/D2;
T1=3.77;
%T1=7.55;
% Area state vector x1=[dPtie df1 dPm1 dE1 dPv1] and x2=[-dPtie df2 dPm2
% dE2 dPv2]and global state vector x=[dPtie x1 x2]
An=[0 (2*pi*T1) 0 0 0 -(2*pi*T1) 0 0 0;-Kp1/Tp1 -1/Tp1 Kp1/Tp1 0 0 0 0 0 0;0 0 -1/Tch1 0 1/Tch1 0 0 0 0;
    k1 (k1*B1) 0 0 0 0 0 0 0;0 -1/(R1*Tg1) 0 -1/Tg1 -1/Tg1 0 0 0 0;Kp2/Tp2 0 0 0 0 -1/Tp2 Kp2/Tp2 0 0;
    0 0 0 0 0 0 -1/Tch2 0 1/Tch2;-k2 0 0 0 0 (k2*B2) 0 0 0;0 0 0 0 0 -1/(R2*Tg2) 0 -1/Tg2 -1/Tg2]
Bn=[0 0;0 0;0 0;0 0;1/Tg1 0;0 0;0 0;0 0;0 1/Tg2]
Dn=[0 0;-Kp1/Tp1 0;0 0;0 0;0 0;0 -Kp2/Tp2;0 0;0 0;0 0]
 %Cn=[1 0 0 0 0 0 0 0 0;0 1 0 0 0 0 0 0 0;0 0 0 0 0 1 0 0 0];
% C12=[1 0 0 0 0 0 0 0 0;0 0 0 0 0 0 1 0 0];
Cn=[1 0 0 0 0 0 0 0 0;0 1 0 0 0 0 0 0 0;0 0 1 0 0 0 0 0 0;0 0 0 0 0 1 0 0 0;0 0 0 0 0 0 1 0 0]
eig(An);
%@@@@@@@@@@@@@@@@    Regular form     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
desired_polesf=[-3.5,-5.8,-3 + 0.2967i,-3-0.2967i,-5.6145,-4.8238,-7,-8,-9];
Kf=place(An,Bn,desired_polesf)

Ab=vertcat(horzcat(An,Dn),horzcat(zeros(2,9),zeros(2,2)))
Bb=vertcat(Bn,zeros(2,2))
Eb=vertcat(zeros(9,2),eye(2))
Cb=horzcat(Cn,zeros(5,2))

K1=place(Ab',Cb',[-30 -21 -98 -22 -25 -36 -22 -39 -45 -50 -55]);
L=K1'
% dp=Ab*p+Bb*u+L*(y-Cb*p);
h=0.01
