clc
clear all
close all
pop=60; % initial population
% initial parameter values
a10=.5; 
a12=45*.05;
a21=45*.01;
a20=.2;
q=[a10 a12 a21 a20];
qg=[a10*(1+.1*randn) a12*(1+.1*randn) a21*(1+.1*randn) a20*(1+.1*randn)];
%Initial Conditions
Pred=.25*pop;
Prey=.75*pop;
tstop=100;
options = [];

% load correct bigQ 
t=1:tstop;
t=t';
load('bigQmat_stochastic_small_365.mat')
% Process covariance

% initialize everything
g=eye(6);
H=[0,1,0,0,0,0];
V=eye(1);
Pminus = eye(6);
P=mat2vec(Pminus);

s=tstop;
xStore=[];
psi = 10^(-3)
R=150
bigQ=psi*bigQ;
ntrials = 1000;
xStore=zeros(100,6,100);