function [q] = CostFunction_Stoch_PP(data,tspan,y0,parameters)
% Cost function
[t1,y1]=ode45(@dydt_Stoch_PP,tspan,y0,[],parameters);
w = y1(:,2); 
if length(w)==length(data)
    q = sum((data-w).^2);
else
    w(length(w)+1:length(data))=0;
    q = sum((data-w).^2);
end
function zdot = dydt_Stoch_PP(t,I,a) 
zdot=[a(1)*I(1)-a(2)*I(1)*I(2);a(3)*I(1)*I(2)-a(4)*I(2)];
end
end