% Predator-Prey Stochastic Simulation 
% clear all
% close all

function [binX,binY] = stochasticPP(nsamp,tspan,init_vec,theta,seedval)

a10 = theta(1);
a12 = theta(2);
a21 = theta(3);
a20 = theta(4);
pop = theta(5);
%rand('seed',seed)

%% Stochastic Model
for n=1:nsamp
    rand('seed',seedval(n))
    X=init_vec(1);
    Y=init_vec(2);
    clear storet storeX storeY
    t=0;
    i=1;
    storeX=zeros(tspan,1);
    storeY=zeros(tspan,1);
    storet=zeros(tspan,1);
    
    while(t<tspan) && (X>1) && (Y>1)
        storeX(i)=X;
        storeY(i)=Y;
        storet(i)=t;
        
        lambda = [a10*X a21*X*Y/pop a12*X*Y/pop a20*Y]; %Transition probabilities
        
        lambdatot = sum(lambda);
        
        mean0 = 1/lambdatot;
        tau = exprnd(mean0);
        r2 = rand(1);
        
        if(r2<lambda(1)/lambdatot)
            X=X+1;
            Y=Y;
        elseif((lambda(1)/lambdatot)<r2 && r2<=((lambda(1)+lambda(2))/lambdatot))
            X=X;
            Y=Y+1;
        elseif((lambda(1)+lambda(2))/lambdatot<r2 && r2<=((lambda(1)+lambda(2)+lambda(3))/lambdatot))
            X=X-1;
            Y=Y;
        else
            X=X;
            Y=Y-1;       
        end
        t=t+tau;
        i=i+1;               
    end
    
    run(n).storet = storet;
    run(n).storeX = storeX;
    run(n).storeY = storeY;
%     plot(run(n).storet,run(n).storeY)
%     hold on
end

%Binning Y
for j=1:nsamp
    [binX(:,j) binY(:,j)] = binningPP(j,tspan,run);
end


end
            
        
