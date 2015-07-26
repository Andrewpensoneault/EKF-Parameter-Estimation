%Initial Conditions
ntrials=1000;
% Numerical Solutions
options = [];
[t,y]=ode45(@pp_ode_6_19,0:1:tstop,[Prey,Pred],options,parameters);        %Get Data 
% Generate noisy data in I
Q=Q/10;
g=eye(6);
H=[0,1,0,0,0,0];
V=eye(1);
% Weight for Noise
%initial conditions
a100=a10*(1+.1*randn);
a120=a12*(1+.1*randn);
a210=a21*(1+.1*randn);
a200=a20*(1+.1*randn);
q=abs([a100,a120,a210,a200]);
Pminus = eye(6);
P=mat2vec(Pminus);
s=size(t);
% figure
% plot(t,y(:,2),'-b')
% xlabel('Time t');ylabel('Population');
save Q.mat Q