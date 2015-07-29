function [y] = Euler(k,IC,Q,t,g)
y=IC;
T=10;
for i=k:t:k+1
    y=y+t*PPmodwP(T,y,g,Q);
end
end