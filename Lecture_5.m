%Lecture 5

%Read 2015 electricity demand data
data = csvread('hourly-day-ahead-bid-data-2015.csv',5,1);
vector = MatToVec(data);

%Read 2014 electricity demand data
bizarre_data = csvread('bizarre_data.csv');

%Pre-process Data
% issues: zeroes, large values, negative
processed_data = pre_processor(bizarre_data);

candidates = find(processed_data > 130000);
index = candidates(find(candidates>7000));
day = floor(index/24);
hour = index - day*24;
answer = [day hour];


%histogram
figure;
subplot(2,2,1)
histogram(processed_data,100); 
xlabel('Demand (MWh)','FontSize', 14)
ylabel('Frequency','FontSize', 14)
title('Pre-processed 2014 Data', 'FontSize',14)

%qqplot
subplot(2,2,2)
qqplot(processed_data); 
xlabel('Theoretical Normal Quantiles','FontSize',14)
ylabel('Empirical Data Normal Quantiles','FontSize',14)
title('QQ Plot of Pre-Processed Demand Data','FontSize',14)

%log transformation
transformed_data = log(processed_data); 

% histogram
subplot(2,2,3)
histogram(transformed_data,100); 
xlabel('log-Demand (MWh)','FontSize', 14)
ylabel('Frequency','FontSize', 14)
title('Log-Transformed 2014 Data', 'FontSize',14)


%qqplot
subplot(2,2,4)
qqplot(transformed_data);
xlabel('Theoretical Normal Quantiles','FontSize',14)
ylabel('Empirical Data Normal Quantiles','FontSize',14)
title('QQ Plot of Log-Transformed Demand Data','FontSize',14)

%mean
mu = mean(processed_data); 
dev = std(processed_data); 

%number of standard deviations weird point is away from mean
number_stds = (processed_data(index) - mu)/dev;

%random energy demand spike-- take stastical info in context and see if
%it's an outlier there
%do it 700 data points at a time
%1-701, 2-702, 3-702 and then remove outliers
%and do data mining part too

%% Other way

outlier_std=3; 
processed_data2=processed_data;
for i=1:(length(processed_data)-700)
    mean700=mean(processed_data(i:i+699));
    std700=std(processed_data(i:i+699));
    for j=i:(i+699)
        if processed_data(j)>(mean700+outlier_std*std700)||processed_data(j)<mean700-outlier_std*std700
            processed_data2(j)=(processed_data(j+1)+processed_data(j-1))/2;
        %elseif processed_data(j)<mean700-outlier_std*std700
         %   processed_data2(j)=(processed_data(j+1)+processed_data(j-1))/2;
        else
            processed_data2(j)=processed_data(j);
        end
        j=j+1;  
    end
    i=i+1; 
end

figure;
subplot(1,2,1)
plot(processed_data)
title('Original Process')
subplot(1,2,2)
plot(processed_data2)
title('Outlier Elimination Method 2')
 
%histogram
figure;
subplot(2,2,1)
histogram(processed_data2,100); 
xlabel('log-Demand (MWh)','FontSize', 14)
ylabel('Frequency','FontSize', 14)
title('2014 Data: Outlier Elimination Method 2', 'FontSize',14)


%qqplot
subplot(2,2,2)
qqplot(processed_data2);
xlabel('Theoretical Normal Quantiles','FontSize',14)
ylabel('Empirical Data Normal Quantiles','FontSize',14)
title('2014 Data: Outlier Elimination Method 2','FontSize',14)                
            
%log transformation 2 

transformed_data2 = log(processed_data2); 

% histogram
subplot(2,2,3)
histogram(transformed_data2,100); 
xlabel('log-Demand (MWh)','FontSize', 14)
ylabel('Frequency','FontSize', 14)
title('Log-Transformed 2014 Data 2', 'FontSize',14)

%qqplot
subplot(2,2,4)
qqplot(transformed_data2);
xlabel('Theoretical Normal Quantiles','FontSize',14)
ylabel('Empirical Data Normal Quantiles','FontSize',14)
title('QQ Plot of Log-Transformed Demand Data 2','FontSize',14)                

%% Data Mining

%peaaakakaaaaakakakakaakakak

peak=zeros(365,1);

i=1;
for j=1:365
    peak(j)=max(processed_data2(i:i+23));
    j=j+1;
    i=i+24;
end

figure
plot(peak)
xlabel('Days');
ylabel('Daily Peak Electricity Demand (MWh)');
title('Daily Peak Electricity Demand in 2014');

%%
%Read temp data data
temperature = csvread('tempdata.csv');

figure
scatter(temperature(:,2), peak)
xlabel('Temperature (F)');
ylabel('Peak Demand (MWh)');

                
                