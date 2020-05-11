function Y = Generate_Data(len)

e=normrnd(0,1,[1,len-1]);
alpha0=0.01;
alpha1=0.3;
beta1=0.6;
Y = zeros(1,len);
Sigma = zeros(1,len);
Y(1)=0.01;
Sigma(1)=0.05;
for n = 1:len-1
    Sigma(n+1) = sqrt(alpha0+alpha1*Y(n)^2+beta1*Sigma(n)^2);
    Y(n+1) = Sigma(n+1)*e(n);
end
