clear all
clc
rand('seed',1)%Set Seed
%%%small pop
warning off
diary on
fprintf('N is 60\n')
N=60;
a10=.5;
a12=(45/N)*.05;
a21=(45/N)*.01;
a20=.2;
Pred=.25*N;
Prey=.75*N;
parameters=[a10 a12 a21 a20];
%%psi=1
Psi=1;
rng(1,'twister')%Set Seed
fprintf('Psi is 1 \n')
Initialize
basic_6_19
params
%%psi=.1
for Psi=[.1,.01,.001,.0001]
    rng(1,'twister')%Set Seed
    fprintf('Psi is %1.5f\n',Psi)
    Pminus = eye(6);
    P=mat2vec(Pminus);
    save Q.mat Q
    basic_6_19
    params
end
diary off