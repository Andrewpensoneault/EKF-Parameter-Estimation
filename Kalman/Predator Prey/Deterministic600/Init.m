
Q=Q/10;
% Weight for Noise
q=abs([a100,a120,a210,a200]);
Pminus = eye(6);
P=mat2vec(Pminus);
s=size(t);
% figure
% plot(t,y(:,2),'-b')
% xlabel('Time t');ylabel('Population');
save Q.mat Q