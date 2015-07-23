function [ydot]=pp_ode(t,y,a)
ydot=[y(1)*(a(1)-a(2)*y(2));y(2)*(a(3)*y(1)-a(4))];
end