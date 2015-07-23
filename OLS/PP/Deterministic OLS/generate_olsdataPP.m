function generate_olsdataPP

close all
clear all
clc

% Exact Parameters
N=60;
a=.5;
b=.05*(45/N);
c=(45/N)*.01;
d=.2;



%Initial Conditions
x=.75*N;  % initial prey
y=.25*N; % initial predator
tstop=100; % stopping time

% Numerical Solutions
parameters=[a b c d]; %vector of parameters
options = [];
[t,y]=ode45(@pp_ode,0:1:tstop,[x y],options,parameters); % solve the ode system
% Plot deterministic system
figure(1)
subplot(1,2,1)
hold on
plot(t,y(:,1),'b-',t,y(:,2),'r-')
xlabel('Time');ylabel('Population');
legend('Prey','Predator')

% Generate noisy data in I
%yobs1 = y(:,2);
yobs1 = y(:,2) + sigma0.*randn(size(y(:,2),1),1);
% Save output
m1 = [t yobs1];
save('syndata_PP_ols.txt','-ascii','m1');
%Plot noisy data in I
subplot(1,2,2)
plot(t,y(:,2),'-b',t,yobs1,'rx')
xlabel('Time');ylabel('Population');
legend('Forward Solution','Synthetic Data');


function ydot=PPModel(t,y,a)
ydot=[y(1)*(a(1)-a(2)*y(2));y(2)*(a(3)*y(1)-a(4))];
end
end