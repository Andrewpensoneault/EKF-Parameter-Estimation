First
% kalman filter - 6 seconds per trial
for i=1:ntrials
    % load or create data
    [~,y]=ode45(@pp_ode_6_19,1:1:tstop,[Prey,Pred],options,q,pop);
    data=y(:,2)+r*randn(length(y(:,2)),1);
    xStore(1,:,i) = [Prey,data(1),qg];%Stores results of trial
    IC = [Prey;data(1);qg';P]; %Initial conditions
    for k=2:length(data)-1
        % Time update
        x=Euler(k,IC,bigQ(:,:,k),.0005,g,pop);
        xhatminus= x(1:6);%takes states and parameters
        Pminus = x(7:end);%takes covariance
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
    tt=size(t);
     Esti1=xStore(find(xStore(:,3,i)~=0),3,i);
     Esti2=xStore(find(xStore(:,4,i)~=0),4,i);
     Esti3=xStore(find(xStore(:,5,i)~=0),5,i);
     Esti4=xStore(find(xStore(:,6,i)~=0),6,i);
     params(i,1)=Esti1(end);
     params(i,2)=Esti2(end);
     params(i,3)=Esti3(end);
     params(i,4)=Esti4(end);
%     [tdeterm,ydeterm]=ode23s(@pp_ode_6_19,0:1:tstop,[Prey,Pred],options,q,pop);
% [tdeterm_e,ydeterm_e]=ode23s(@pp_ode_6_19,0:1:tstop,[Prey,Pred],options,params(i,:),pop);
% figure
% plot(tdeterm,ydeterm(:,2),tdeterm_e,ydeterm_e(:,2))
% [q;params]
%   
% figure
% plot(1:length(data),data,'rx',1:length(data)-1,xStore(find(xStore(:,2,i)~=0),2,i),'k-.',tdeterm,ydeterm(:,2),'-')
% legend('data','Predictted I','Deterministic')
% 
% figure
% plot(1:length(data)-1,xStore(find(xStore(:,2,i)~=0),1,i))
% title('Prey')
% 
% 
% figure
% plot(1:length(data)-1,xStore(find(xStore(:,2,i)~=0),3,i))
% title('a_{10}')
% 
% figure
% plot(1:length(data)-1,xStore(find(xStore(:,2,i)~=0),4,i))
% title('a_{12}')
% 
% figure
% plot(1:length(data)-1,xStore(find(xStore(:,2,i)~=0),5,i))
% title('a_{21}')
% 
% figure
% plot(1:length(data)-1,xStore(find(xStore(:,2,i)~=0),6,i))
% title('a_{20}')
end
interval(params,q)
params