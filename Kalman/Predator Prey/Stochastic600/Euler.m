function [y] = Euler(k,IC,Q,t,g,pop)
y=IC;
T=10;
for i=k:t:k+1
    y=y+t*PPmodwP(T,y,g,Q,pop);
end
end