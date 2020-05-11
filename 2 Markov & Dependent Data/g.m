function fun=g(y,x,sigma)
fun=1/sqrt(2*pi)*exp(-(y-(sigma(1)+sigma(2)*x))^2/2);