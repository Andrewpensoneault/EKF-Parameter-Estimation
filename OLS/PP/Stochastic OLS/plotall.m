function [approx] = plotall(parameters,tspan,init,data)
%Numerical Solutions
[~,p]=size(parameters);
figure
for i=1:p
options = [];
[t,y]=ode45(@dydt_Stoch_PP,tspan,init,[],parameters(:,i));
approx = y;
% Plot system
hold on
plot(t,data(:,i+1),'.',t,approx(:,2),'--')
title('The PP Model')
end
function zdot = dydt_Stoch_PP(t,I,a) 
zdot=[a(1)*I(1)-a(2)*I(1)*I(2);a(3)*I(1)*I(2)-a(4)*I(2)];
end
end