%% driver_ols_estimationPP
% Ordinary Least Squares estimation for PP (ODE) model
close all
clc
clear all
ntrials=1000;
% Initial guesses for parameter estimation
% Exact values
N=600;
a0=.5;
b0=(45/N)*.05;
c0=(45/N)*.01;
d0=.2;    
%% Initial conditions for ODE system
init = [.75*N;.25*N];
theta0 = [a0;b0;c0;d0];
tstop=100;
%St.Dev. for Noise
sigma0=sqrt(1);
%% Parameters 
a=a0*(.1*randn+1);
b=b0*(.1*randn+1);
c=b0*(.1*randn+1);
d=d0*(.1*randn+1);
theta1=[a;b;c;d];
for i=1:ntrials  
    %% Load data generated from odesysSIS.m
    options=[];
    [t,y]=ode45(@pp_ode,0:1:tstop,init,options,theta0); % solve the ode system
    y(:,2)=y(:,2)+(1+randn(length(y),1)*sigma0);
    Preddata(:,i) = y(:,2);
    %% Optimization
    %options=optimset('Display','iter','MaxFunEvals',1e3,'MaxIter',1000,'TolFun',1e-30,'TolX',1e-30);
    thetahat(:,i) = fminsearch(@(theta)costfunctionPP(Preddata(:,i),t,init,theta), theta0, options);
    i
end
clc 
thetahat
meanbb=mean(thetahat');
SEM = std(thetahat')/sqrt(ntrials);              % Standard Error
ts = tinv([0.025  0.975],(ntrials-1));           % T-Score
CIH = meanbb + ts(2)*SEM;                        % Confidence Intervals
CIL = meanbb - ts(2)*SEM;
errorr = abs(100*(meanbb-theta0')./theta0');
fprintf('With confidence of .95, a10 lies within %1.4f < %1.4f < %1.4f with an error of %1.4f%%\n',CIL(1),meanbb(1),CIH(1),errorr(1))
fprintf('With confidence of .95, a12 lies within %1.4f < %1.4f < %1.4f with an error of %1.4f%%\n',CIL(2),meanbb(2),CIH(2),errorr(2))
fprintf('With confidence of .95, a21 lies within %1.4f < %1.4f < %1.4f with an error of %1.4f%%\n',CIL(3),meanbb(3),CIH(3),errorr(3))
fprintf('With confidence of .95, a20 lies within %1.4f < %1.4f < %1.4f with an error of %1.4f%%\n',CIL(4),meanbb(4),CIH(4),errorr(4))