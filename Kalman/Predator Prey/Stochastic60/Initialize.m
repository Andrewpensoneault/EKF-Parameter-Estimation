%Initial Conditions
tstop=100;
ntrials=1000;
% Numerical Solutions
options = [];
[t,y]=ode45(@pp_ode_6_19,0:1:tstop,[Prey,Pred],options,parameters);        %Get Data 
true=y(2:end,2);
% Generate noisy data in I
Q=BigQ1(10,Psi,parameters,[Prey,Pred],365,10);                               % Process covariance                                                                    
g=eye(6);
H=[0,1,0,0,0,0];
V=eye(1);
% Weight for Noise
%initial conditions
Pminus = eye(6);
P=mat2vec(Pminus);
s=size(t);
% figure
% plot(t,y(:,2),'-b')
% xlabel('Time t');ylabel('Population');
save Q.mat Q