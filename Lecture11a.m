%Lecture11

% data=xlsread('temp_demand.xlsx');
t_data = xlsread('temp_demand.xlsx','training');
v_data = xlsread('temp_demand.xlsx','validation');
t_temps = t_data(:,1);
t_demand = t_data(:,3);
v_temps = v_data(:,1);
v_demand = v_data(:,3);

t_CDD = max(t_temps - 65,0);
t_HDD = max(65 - t_temps,0);
v_CDD = max(v_temps - 65,0);
v_HDD = max(65 - v_temps,0);

X = [ones(length(t_CDD),1) t_CDD t_HDD];

[BETA,SIGMA,RESID]=mvregress(X,t_demand);
%RESID shows a pattern, so the regression is not good for the data
%BETA= coefficients: y intercept, C1, C2
%electricity demand more sensitive to a cooling degree day

predicted_demand=ones(length(v_HDD),1); 
c=BETA(1,1);
b_CDD=BETA(2,1);
b_HDD=BETA(3,1);

for i=1:length(predicted_demand)
    predicted_demand(i)=c+b_CDD*v_CDD(i)+b_HDD*v_HDD(i);
end 

rows=length(predicted_demand);
compare=ones(rows,2);
compare(:,1)=v_demand;
compare(:,2)=predicted_demand; 

figure;
scatter(predicted_demand,v_demand)
hold on
xlim([8000, 20600]);
xlabel('Predicted demand (GWh)')
ylim([8000, 20600]);
ylabel('Actual demand (GWh)')
title('Predicted Demand versus Actual Demand')

%figure;
%plot(compare);
%title('Time Series Data')

%R_square

SSE=0;
for i=1:length(v_demand) 
    SSE=SSE+(v_demand(i)-predicted_demand(i))^2;
end 

mu=mean(v_demand);

SST=0;
for i=1:length(v_demand) 
    SST=SST+(v_demand(i)-mu)^2;
end

R_squared=1-(SSE/SST)

sum=0;
for i=1:length(v_demand) 
    sum=sum+(v_demand(i)-predicted_demand(i))^2;
end
RMSE=sqrt(sum/length(v_demand))

figure; 
residuals=predicted_demand-v_demand;
scatter(v_demand,residuals)
title('Actual Demand versus Residuals');
xlabel('Actual Demand (MWh)');
ylabel('Residuals');



