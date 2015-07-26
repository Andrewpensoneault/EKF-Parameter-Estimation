function vec=mat2vec(mat)
n=length(mat);
vec=zeros(n^2,1);
for i=1:n^2
    vec(i)=mat(i);
end