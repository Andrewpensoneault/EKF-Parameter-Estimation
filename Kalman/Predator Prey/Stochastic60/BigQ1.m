function Q = BigQ1(N,psi,parameters,IC,time,nsamp)
%This function takes the number of "runs" of the ode system (N) with
%randomly variated parameter values(beta gamma) and the fine tuning value
%(psi) of the filter and calculates a Q matrix which is 3x3x#timesteps. 
% Q(t_k) = psi * 1/N * summmation(j = 1,N) (x(t_k)) - xbar)(x(t_k) - xbar)'
% IC = initial infected population
% pop = Total population


a100 = parameters(1);
a120 = parameters(2);
a210 = parameters(3);
a200 = parameters(4);
tstop = time;

for i=1:N %calculates our state value(I) and beta and gamma based on deterministic(ODE) system at each time step (1:365) ten different times(new param guesses).
    a10val = a100 * (1 + .01*randn);
    a12val = a120 * (1 + .01*randn);
    a21val = a210 * (1 + .01*randn);
    a20val = a200 * (1 + .01*randn); 
    
    a10(1+nsamp*(i-1):i*nsamp,1) = a10val*ones(nsamp,1);
    a12(1+nsamp*(i-1):i*nsamp,1) = a12val*ones(nsamp,1);
    a21(1+nsamp*(i-1):i*nsamp,1) = a21val*ones(nsamp,1);
    a20(1+nsamp*(i-1):i*nsamp,1) = a20val*ones(nsamp,1);
    
    seedval = randi([20,2^(32)-1],nsamp,1);
    q=[a10val,a12val,a21val,a20val];
    [Prey,Pred]=stochgen(q,IC,time,nsamp,seedval);
    Preymat(:,1+nsamp*(i-1):i*nsamp)=Prey;
    Predmat(:,1+nsamp*(i-1):i*nsamp)=Pred;
end

[m,n]=size(Preymat);
for k=1:m
    
    Qtemp = zeros(6,6); %start with blank Q matrix.
    
    xbar = [mean(Preymat(k,:));mean(Predmat(k,:));...
        mean(a10); mean(a12);mean(a21);mean(a20)];
    
    for j=1:n
        x = [Preymat(k,j);Predmat(k,j); a10(j); a12(j); a21(j); a20(j)];
        
        Qtemp = Qtemp + (x-xbar)*(x-xbar)';
    end
    
    Q(:,:,k) = psi * (1/N) * Qtemp;
end
end
