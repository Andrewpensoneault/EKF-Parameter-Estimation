function [approx] = plotodesysPP(theta,data,init)
%Numerical Solutions
options = [];
[t,y]=ode45(@PPModel,data(:,1),init,options,theta); 

approx = y(:,2);
% Plot deterministic system
hold on
plot(data(:,1),data(:,2),'k.',t,approx,'b-')
legend('data','best fit model');
title('The PP Model')


function ydot=PPModel(t,y,a)
ydot=[y(1)*(a(1)-a(2)*y(2));y(2)*(a(3)*y(1)-a(4))];
end
end

