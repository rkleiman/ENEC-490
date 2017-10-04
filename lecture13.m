%Lecture13

%Read electricity demand data
[data]= csvread('hourly-day-ahead-bid-data-2015.csv',5,1); %row=day, column= hour
v = MatToVec(data);

for i=1:length(v)
    if v(i)<100
        v(i) = (v(i-1)*.5+v(i+1)*.5);
    end
end

%winter
figure;
autocorr(v(1:1200)); %defaults to 20 lags, where the lag is the distance between the points
title('Winter Autocorrelation')

%summer
figure;
autocorr(v(4000:5199));
title('Summer Autocorrelation')

%fall
figure;
autocorr(v(6000:7200));
title('Fall Autocorrelation')

%% calculate peak demand
peak= zeros(365,1);

for i=1:365
    peak(i)=max(data(i,:));
end

figure;
autocorr(peak,60)
title('Peak Demand Autocorrelation')
%about 43 days before is the earliest

%% differencing

diff = zeros(365,1);

for i=1:364
    diff(i)=peak(i+1)-peak(i);
end

figure;
autocorr(diff,60); 
title('Autocorrelation of Differencing')

figure;
plot(diff)
title ('Plot of Differenced Peak Demand Values'); 
xlabel('Days')
ylabel('Difference')

%% mean

smooth=zeros(335,1);

for i=1:335
    smooth(i)=mean(peak(i:i+30));
end

peak2=peak(16:350);
figure;
plot(peak2)
hold on
plot(smooth)
legend ('Peak data', 'Smoothed data')
xlabel ('Day')
ylabel ('Energy demand')
title ('Peak and Smoothed Data')

residual= peak2 - smooth;
figure;
autocorr(residual)
title ('Residuals')
%low autocorrelation, which means the residuals are white noise




