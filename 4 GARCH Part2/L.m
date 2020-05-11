function like=L(Y,y0,sigma0,Para)
Sigma=zeros(1,length(Y));
Sigma(1)=sqrt(Para(1)+Para(2)*y0^2+Para(3)*sigma0^2);
for n = 2:length(Y)
    Sigma(n) = sqrt(Para(1)+Para(2)*Y(n-1)^2+Para(3)*Sigma(n-1)^2);
end
like=0;
for n=1:length(Y)
    like=like-Y(n)^2/(2*Sigma(n)^2)-log(sqrt(2*pi)*Sigma(n));
end