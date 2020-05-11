function like=L(X,sigma)
like=0;
for n = 1:length(X)
    like=like+log(g(X(n),sigma));
end
like=like/length(X);
end