%generate data
rng(1);
X=normrnd(5,0.1,[1,100]);
sigma=0.1;
%L is the likelihood function to be maximized;lkh is to be minimized
%L is the sum of log density of Xi
lkh=@(miu)-L(X,miu,sigma);
%get MLE and the value of lkh when miu equals MLE
[MLE,fval,~,~,~,hessian]=fminunc(lkh,5);
%test when we got the correct MLE
miuhat = sum(X)/length(X);
%get sigma_square_hat
syms a;
miu=MLE;
t2=diff(L(X,a,sigma),2);
diff2=subs(t2,'a',MLE);
sigma_square_hat=(-diff2/length(X))^(-1);
%sigmahat approximately follows a normal distribution with mean sigma_zero
%and variance sigma_square/n
%the confidence interval(95%) for the true parameter sigma_zero is
lower_bound=MLE-1.96*sqrt(sigma_square_hat/100); %4.9755
upper_bound=MLE+1.96*sqrt(sigma_square_hat/100); %5.0147
%p_value
z=(MLE-5)/sqrt((sigma_square_hat/length(X)));
p_value=2*(1-normcdf(abs(z)));




