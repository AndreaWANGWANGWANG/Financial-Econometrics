function X = Generate_Markov_Data
rng(1);
e=normrnd(0,1,[1,999]);
alpha=1;
beta=0.6;
X = zeros(1,1000);
X(1)=2;
for n = 1:999
    X(n+1) = alpha + beta*X(n) + e(n); 
end
