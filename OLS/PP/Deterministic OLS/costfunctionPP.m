function val = costfunctionPP(data,timespan,init_vec,theta)
% Theta = parameters

options = [];
[t,y]=ode45(@pp_ode,timespan,init_vec,[],theta); 

w = y(:,2);

% Cost Function model form
val = sum((data-w).^2);
end