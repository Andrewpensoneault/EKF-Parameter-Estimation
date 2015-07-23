function[Preddata]=SSA_PP(q,init,tspan,nsamp)
close all % close all figures
clc % clear the screen
Prey0 = init(1); % Initialize the initial state Prey
Pred0 = init(2); % Initialize the initial state Pred
a = q(1);  
b = q(2); 
c = q(3);
d = q(4);
% Stochastic solution
for j=1:nsamp % do for the desired number of samples
    clear Pred Prey t% clear the values from the previous realization
    
    count = 1; % initialize counter
    t(count) = 0; % set initial time
    Prey(count) = Prey0; % initialize state
    Pred(count) = Pred0; % initialize state
    
    % continue the loop until one of the populations dies off or reach the
    % maximum time
    while (Pred(count) > 0) && (Prey(count) > 0) && (t(count)<tspan)
        
        count = count + 1;
        
        rates = [a*Prey(count-1),b*Prey(count-1)*Pred(count-1),c*Prey(count-1)*Pred(count-1),d*Pred(count-1)];  % Transistion rates
        
        R = sum(rates);        % Sum of all transition rates
        
        tau = exprnd(1/R);   % Draw from exponential distribution
        
        u2 = rand(1); % Draw from a uniform distribution for transition
        
        if(u2<rates(1)/R) % Birth Prey
            Prey(count) = Prey(count-1)+1;
            Pred(count) = Pred(count-1)+0;
        elseif(u2<(rates(1)+rates(2))/R) % Death Pred
            Prey(count) = Prey(count-1)-1;
            Pred(count) = Pred(count-1)+0;
        elseif(u2<(rates(1)+rates(2)+rates(3))/R) %Birth Pred
            Prey(count) = Prey(count-1)+0;
            Pred(count) = Pred(count-1)+1; 
        else                                  %Pred Death
            Prey(count) = Prey(count-1)+0;
            Pred(count) = Pred(count-1)-1;
        end
        
        t(count)=t(count-1)+tau; % update the time
       
    end
    run(j).t=t;
    run(j).Prey=Prey;
    run(j).Pred=Pred;
end
Preydata=binnPrey(nsamp,tspan,run);
Preddata=binnPred(nsamp,tspan,run);
data=struct('Prey',Preydata,'Pred',Preddata);

function[Preydata]=binnPrey(j,tspan,run)
meanPrey=zeros(1,tspan);
Preydata=[];
Preydata(:,1)=1:tspan;
for n=1:j
    for day=1:tspan
        clear Preyvect;
        Preyvect=[];
        index_j = find(day-1 <= run(n).t & run(n).t < day);
        if ~isempty(index_j)
            Preyvect = [Preyvect run(n).Prey(index_j)];
        end
        if  isempty(Preyvect)
            meanPrey(day)=meanPrey(day-1);
        else
            meanPrey(day)=mean(Preyvect);
        end
    end
    Preydata(:,n+1)=meanPrey;
end
end 
function[Preddata]=binnPred(j,tspan,run)
meanPred=zeros(1,tspan);
Preddata=[];
Preddata(:,1)=1:tspan;
for n=1:j
    for day=1:tspan
        clear Predvect;
        Predvect=[];
        index_j = find(day-1 <= run(n).t & run(n).t < day);
        if ~isempty(index_j)
            Predvect = [Predvect run(n).Pred(index_j)];
        end
        if isempty(Predvect)
            if run(n).Prey~=0 & run(n).Pred~=0 
                meanPred(day)=meanPred(day-1);
            else
                meanPred(day)=0;
            end
        else
            meanPred(day)=mean(Predvect);
        end
    end
    Preddata(:,n+1)=meanPred;
end
end 
end
