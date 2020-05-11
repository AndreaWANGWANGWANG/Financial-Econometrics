function like=L(X,sigma)
like=0;
for n = 1:(length(X)-1)
    like=like+log(g(X(n+1),X(n),sigma));
end
end