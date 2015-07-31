function Q = qgen(N,psi,parameters,IC,time,pop)
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
    a10(i) = a100 * (1 + 0.01*randn);
    a12(i) = a120 * (1 + 0.01*randn);
    a21(i) = a210 * (1 + 0.01*randn);
    a20(i) = a200 * (1 + 0.01*randn);
    q=[a10(i),a12(i),a21(i),a20(i)];
    options = [];
    [t,y]=ode23s(@pp_ode_6_19,1:1:tstop,[IC],options,q,pop);
    Predmat(:,i) = y(:,2); %stores state values(I) for each run i at each timestep from 1-365.
    Preymat(:,i) = y(:,1);
end

for k=1:time
    
    Qtemp = zeros(6,6); %start with blank Q matrix.
    
    xbar = [mean(Preymat(k,:));mean(Predmat(k,:)); mean(a10); mean(a12);mean(a21);mean(a20)];
    
    for j=1:N
        x = [Preymat(k,j);Predmat(k,j); a10(j); a12(j); a21(j); a20(j)];
        
        Qtemp = Qtemp + (x-xbar)*(x-xbar)';
    end
    
    Q(:,:,k) = psi * (1/N) * Qtemp;
end
end