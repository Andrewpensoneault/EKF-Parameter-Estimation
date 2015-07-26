% kalman filter - 6 seconds per trial
xStore=[];
params=[];
for i=1:ntrials
    count=0;
    data = y(:,2) + r.*randn(size(y(:,2),1),1);   %generates noisy data
    R=sum((data-true).^2)/(length(data)-1);
    fprintf('R is %i\n',R)
    xStore(1,:,i) = [Prey,data(1),q];%Stores results of trial
    IC = [Prey;data(1);q';P]; %Initial conditions
    xhat=[Prey;data(1);q'];
    for k=2:length(data)
        % Time update
        [T,x] = ode23s(@PPmodwP,k:k+1,IC,options,g,Q(:,:,k)); %generates point at time t
        xhatminus= x(end,1:6)';%takes states and parameters
        Pminus = x(end,7:end)';%takes covariance
        Pminus = vec2mat(Pminus);
        Pminus = (Pminus+Pminus')/2;%make symmetric
        % Measurement update
        Kalmangain=Pminus*H'*inv(H*Pminus*H'+ V*R*V');
        xhat = xhatminus + Kalmangain*(data(k)-H*xhatminus);
        xStore(k,:,i) = xhat';
        Pplus=(eye(6)-Kalmangain*H)*Pminus;
        IC(1:6)=xhat(1:6);
        IC(7:42)=mat2vec(Pplus);
    end
    %Parameter Estimate
    Esti1=xStore(find(xStore(:,3,i)~=0),3,i);
    Esti2=xStore(find(xStore(:,4,i)~=0),4,i);
    Esti3=xStore(find(xStore(:,5,i)~=0),5,i);
    Esti4=xStore(find(xStore(:,6,i)~=0),6,i);
    params(i,1)=Esti1(end);
    params(i,2)=Esti2(end);
    params(i,3)=Esti3(end);
    params(i,4)=Esti4(end);
end
params=params(find(~isnan(params(:,1))),:);
params=params(find(params(:,1)~=0),:);
interval(params,parameters)