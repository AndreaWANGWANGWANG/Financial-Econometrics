function like=L(X,miu,sigma)
like=0;
for n = 1:100 
    like=like+log(f(X(n),miu,sigma));
end
end