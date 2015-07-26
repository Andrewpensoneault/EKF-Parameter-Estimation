function mat=vec2mat(vec)
% turns vector into matrix
n=sqrt(length(vec));
mat=zeros(n,n);
for i=1:n^2
    mat(i)=vec(i);
end
    