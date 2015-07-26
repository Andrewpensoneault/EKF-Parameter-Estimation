%Initial Conditions
tstop=100;
ntrials=1000;
% Numerical Solutions
options = [];
[t,y]=ode45(@pp_ode_6_19,0:1:tstop,[Prey,Pred],options,parameters);        %Get Data 
true=y(1:end,2);
% Generate noisy data in I
Q=qgen(100,Psi,parameters,[Prey,Pred],365);                               % Process covariance                                                                    
g=eye(6);
H=[0,1,0,0,0,0];
V=eye(1);
%St.Dev. for Noise
r=sqrt(1);
%initial conditions
Pminus = eye(6);
P=mat2vec(Pminus);
s=size(t);
% figure
% plot(t,y(:,2),'-b')
% xlabel('Time t');ylabel('Population');
save Q.mat Q