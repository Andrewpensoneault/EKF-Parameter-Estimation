clear all
clc
diary on
rand('seed',1)%Set Seed
%%%medium pop
warning off
fprintf('N is 600\n')
    N=600;
    a10=.5;
    a12=(45/N)*.05;
    a21=(45/N)*.01;
    a20=.2;
    Pred=.25*N;
    Prey=.75*N;
    parameters=[a10 a12 a21 a20];
%%psi=1
    rng(1,'twister')%Set Seed
    Psi=1;
    fprintf('Psi is 1 \n')
    Initialize
    basic_6_19
    params
%%psi=.1
    for Psi=[.1,.01,.001,.0001]
        rng(1,'twister')%Set Seed
        fprintf('psi is %1.5f\n',Psi)
        Init
        basic_6_19
        params
    end
diary off