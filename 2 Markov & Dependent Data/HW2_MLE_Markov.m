%generate a Markov process with 1000 variables
X = Generate_Markov_Data;
%to maximize the likelihood function, we minimize -L
lkh=@(sigma)-L(X,sigma);
[MLE,fval,~,~,~,hessian]=fminunc(lkh,[1.01,0.61]);
%MLE=[0.9881, 0.5992]; that is, alpha_hat=0.9881, beta_hat=0.5992
fval_of_L=-fval;
%fval=1.4158e+03, which means L(X, sigma_hat)=-1.4158e+03
hessian_of_L=-inv((-hessian)/length(X));


sigma_square_hat_for_alpha=hessian_of_L(1,1);
lower_bound_alpha=MLE(1)-1.96*sqrt(sigma_square_hat_for_alpha/length(X));
%lower_bound_alpha is 0.9260.
upper_bound_alpha=MLE(1)+1.96*sqrt(sigma_square_hat_for_alpha/length(X));
%upper_bound_alpha is 1.0501.
z_alpha=(MLE(1)-1)/sqrt(sigma_square_hat_for_alpha/length(X));
p_alpha=2*(1-normcdf(abs(z_alpha)));
%P-Value for alpha is 0.7059.

sigma_square_hat_for_beta=hessian_of_L(2,2);
lower_bound_beta=MLE(2)-1.96*sqrt(sigma_square_hat_for_beta/length(X));
%lower_bound_beta is 0.5767.
upper_bound_beta=MLE(2)+1.96*sqrt(sigma_square_hat_for_beta/length(X));
%upper_bound_beta is 0.6217.
z_beta=(MLE(2)-0.6)/sqrt(sigma_square_hat_for_beta/length(X));
p_beta=2*(1-normcdf(abs(z_beta)));
%P-Value for beta is 0.9440.
%Thus, we cannot reject Ho: alpha=1, beta=0.6.

