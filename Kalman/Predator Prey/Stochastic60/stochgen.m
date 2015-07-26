function[prey,pred]=stochgen(q,init,tspan,nsamp,seedval)
for i=1:nsamp
rand('seed',seedval(i))
Prey0 = init(1); % Initialize the initial state Prey
Pred0 = init(2); % Initialize the initial state Pred
%q=[.5 45*.05/sum(init) 45*.01/sum(init) .2],init=[40 5]
a = q(1);  
b = q(2); 
c = q(3);
d = q(4);
maxtime = tspan; % set the maximum time for iterations
% Stochastic solution 
    count = 1; % initialize counter
    t(count) = 0; % set initial time
    Prey(count) = Prey0; % initialize state
    Pred(count) = Pred0; % initialize state
    
    % continue the loop until one of the populations dies off or reach the
    % maximum time
    while (Pred(count) > 0) && (Prey(count) > 0) && (t(count)<maxtime)
        
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
prey(:,i)=binnPrey(tspan,Pred,Prey,t);
pred(:,i)=binnPred(tspan,Pred,Prey,t);
end
function[Preddata]=binnPred(tspan,Pred,Prey,t)
meanPred=zeros(1,tspan);
Preddata=[];
Preddata(:,1)=1:tspan;
    for day=1:tspan
        clear Predvect;
        Predvect=[];
        index_j = find(day-1 <= t & t < day);
        if ~isempty(index_j)
            Predvect = [Predvect Pred(index_j)];
        end
        if isempty(Predvect)
            if Prey~=0 & Pred~=0 
                meanPred(day)=meanPred(day-1);
            else
                meanPred(day)=0;
            end
        else
            meanPred(day)=mean(Predvect);
        end
    end
    Preddata=meanPred;
end
function[Preydata]=binnPrey(tspan,Pred,Prey,t)
meanPrey=zeros(1,tspan);
Preydata=[];
Preydata(:,1)=1:tspan;
    for day=1:tspan
        clear Preyvect;
        Preyvect=[];
        index_j = find(day-1 <= t & t < day);
        if ~isempty(index_j)
            Preyvect = [Preyvect Prey(index_j)];
        end
        if  isempty(Preyvect) 
            if Prey~=0 & Pred~=0 
                meanPrey(day)=meanPrey(day-1);
            else
                meanPrey(day)=0;
            end
        else
            meanPrey(day)=mean(Preyvect);
        end
    end
    Preydata=meanPrey;
end
end