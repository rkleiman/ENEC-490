%Copied from Lecture4.m 
%Statistics

%see annual_profile2_rkleiman.m for function

%% my notes from class:
%use cell2mat when using the combined matrix
%kwh is energy, kw is just potential to create energy
%yearly changes useful for calculating reserve margin for
%suppliers for excess energy needs (failure in pp, storm, etc.) or for
%looking at trend like when building a new plant

%% 

%1
%Load data from Excel
[data, text, combined] = xlsread('monthly_demandNC.xlsx');
data;

%2
%annual profile
d = annual_profile2(data)

%3
%year on year differences 

[months,years] = size(d); 
differences = zeros(months,years-1);

for i = 1:12
    for j = 1:years-1
        differences(i,j) = (d(i,j+1) - d(i,j))/d(i,j);
    end
end

%create new figure
figure; 
hold on;

%% plot function within for loop
for i  = 1:12
    plot(differences(i,:)*100,'color',rand(1,3));
end

%plot(differnce(1,:)*100; %would give january only
%not much demand growth despite population increase-- energy efficiency, not as much manufacturing
%(switch to service based economy) in NC

xlabel('Year','FontSize',14);
set(gca, 'XTickLabel',{'1998','2000','2002','2004','2006','2008','2010','2012','2014'});
set(gca,'XTick',1:2:18);
ylabel('Demand Growth (%)','FontSize',14);
legend('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');

%% 4
%annual demand percentages
totals = sum(d);
monthly_fractions = zeros(months,years);
for i = 1:years
    monthly_fractions(:,i) = d(:,i)/totals(i);
end

%create new figure
figure; 
hold on;

%plot function within for loop
for i  = 1:12
    plot(monthly_fractions(i,:)*100,'color',rand(1,3));
end

xlabel('Year','FontSize',14);
set(gca, 'XTickLabel',{'1998','2000','2002','2004','2006','2008','2010','2012','2014'});
set(gca,'XTick',1:2:18);
ylabel('% of Total Annual Demand','FontSize',14);
legend('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Location','northwest');


%% 5 
%Simulation

%bootstrapping
num_years = 10;
bootstrap_sample = zeros(12*num_years,1);
for i = 1:num_years
    for j = 1:12
    s = ceil(num_years*rand(1));
    bootstrap_sample((i-1)*12+j) = d(j,s);
    end
end

figure;
%bootstrap sample--doesn't account for that slight upward trend
subplot(1,2,1);
plot(bootstrap_sample);
xlabel('Year','FontSize',14);
ylabel('Demand (MWh)','FontSize',14);
title('Bootsrapped sample')

%autocorrelation
subplot(1,2,2);
autocorr(bootstrap_sample);
xlabel('Months','FontSize',14);
ylabel('Autocorrelation','FontSize',14);

%% 6 Montecarlo

 num_years = 10;
dataMeans = mean(d);
dataSTD = std(d);


newDataset = randn(num_years*months,1);
for x = 1:num_years
    for y = 1:months
        newDataset(y + (x-1)*months) = newDataset(y + (x-1)*months)*dataSTD(y) + dataMeans(y);
    end
end
 

figure;
%montecarlo sample--should account for that slight upward trend
subplot(1,2,1);
plot(newDataset);
xlabel('Year','FontSize',14);
ylabel('Demand (MWh)','FontSize',14);
title('Montecarlo sample')

%autocorrelation
subplot(1,2,2);
autocorr(newDataset);
xlabel('Months','FontSize',14);
ylabel('Autocorrelation','FontSize',14);


