%pre-estimation

Price = xlsread('/Users/xuan/Desktop/PriceSeries1.xls');
%draw a plot of the price series
plot(Price);
set(gca,'XTick',[1 63 125 187 250]) 
set(gca,'XTickLabel',{'Jan 2018' 'April 2018' 'July 2018' 'Oct 2018' 'Dec 2018'}) 
ylabel('Price') 
title('S&P 500 Daily Close Price')
Price_tpls1=Price(2:251);

%get the log return from the close price of S&P 500 from 2018/1/3 to 2018/12/31
logr = log(Price_tpls1)-log(Price(1:250));

%draw a plot of log returns
plot(logr);
set(gca,'XTick',[1 63 125 187 249]) 
set(gca,'XTickLabel',{'Jan 2018' 'April 2018' 'July 2018' 'Oct 2018' 'Dec 2018'}) 
ylabel('Log Return') 
title('S&P 500 Daily Log Returns')

%check for correlation in the log returns series
autocorr(logr) 
title('ACF with Bounds for Log Return Series')
parcorr(logr)
title('PACF with Bounds for Log Return Series')
%As is shown in ACF and PACF of log returns, there is little correlation in the conditional mean

%check for correlation in the squared returns
autocorr(logr.^2) 
title('ACF of the Squared Log Returns')
%The variance process exhibits some correlation

%quantify the correlation
[H,pValue,Stat,CriticalValue] = lbqtest(logr-mean(logr));
%[H pValue Stat CriticalValue]=[0  0.2684 23.4245 31.4104]
%There is no autocorrelation in the log returns


[H2,pValue2,Stat2,CriticalValue2] = lbqtest((logr-mean(logr)).^2);
%[H2,pValue2,Stat2,CriticalValue2] = 1.0000    0.0006   47.0571   31.4104
%There is autocorrelation in the squared log returns

%Estimate the Model Parameters; alpha and beta are statistically significant from zero 
Mdl = garch('GARCHLags',1,'ARCHLags',1);
EstMdl = estimate(Mdl,logr);

%post estimation
%innovations
T=length(logr);
inno=logr-EstMdl.Offset;
plot(inno)
xlim([0,T])
title('innovations')
%Conditional Standard Deviations
v = infer(EstMdl,logr);
sd=sqrt(v);
figure
plot(v)
xlim([0,T])
title('Conditional Standard Deviations')

%plot standardized innovations
plot(inno./sd) 
ylabel('Innovation') 
title('Standardized Innovations')

%the ACF of the squared standardized innovations show no correlation.
autocorr((inno./sd).^2) 
title('ACF of the Squared Standardized Innovations')

%Quantify and Compare Correlation of the Standardized Innovations
[H3, pValue3,Stat3,CriticalValue3] = lbqtest((inno./sd).^2);
%[H3, pValue3,Stat3,CriticalValue3] = 0    0.8384   13.8433   31.4104

[H4, pValue4, Stat4, CriticalValue4] = archtest(inno./sd);

%fit GARCH(1,2)
Mdl12 = garch('GARCHLags',1,'ARCHLags',2);
EstMdl12 = estimate(Mdl12,logr);
%fit GARCH(2,1)
Mdl21 = garch('GARCHLags',2,'ARCHLags',1);
EstMdl21 = estimate(Mdl21,logr);

%Forcast
fc = forecast(EstMdl,1);
%fc = 1.9739e-04

%Robustness test
%break the log returns into to sub-samples
y1=logr(1:125);
y2=logr(126:250);
EstMdlsub1 = estimate(Mdl,y1);
EstMdlsub2 = estimate(Mdl,y2);

