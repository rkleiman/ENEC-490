%Lecture 6- clustering 
temps=csvread('tempdata.csv');
temps=temps(:,2);
%Read electricity demand data
data_2014 = csvread('hourly-day-ahead-bid-data-2014.csv',5,1);
vector = MatToVec(data_2014);
peak = zeros(365,1);

for i=1:365
    peak(i) = max(data_2014(i,:));
end

%GWh vs. MWh changes the dimension that it clusters it by
peak=peak/1000;

% forms 2-column matrix
combined = [temps peak];

% clusters for each row
% kmeans minimizes the distances between the center point and the rest of
% the points
% kmeans(matrix, number of groups)
IDX = kmeans(combined,3);

% forms 3-column matrix
clustered_data = [combined IDX];

% sorts 
sorted_data = sortrows(clustered_data,3);

% find indices of cluster 1
ONE = clustered_data(clustered_data(:,3)==1,1:2);

% find indices of cluster 2
TWO = clustered_data(clustered_data(:,3)==2,1:2);

% find indices of cluster 3
THREE = clustered_data(clustered_data(:,3)==3,1:2);

figure; 
hold on;
scatter(ONE(:,1),ONE(:,2),'r'); 
scatter(TWO(:,1),TWO(:,2) ,'b');
scatter(THREE(:,1),THREE(:,2) ,'g');
xlabel('Average Temperature (degrees F)','FontSize',14);
ylabel('Peak Electricity Demand (MWh)','FontSize',14);
legend('Cluster 1', 'Cluster 2', 'Cluster 3');
hold off;

%% time series data
%daily 
january=data_2014(1:31,:)/1000;
july=data_2014(182:182+30,:)/1000; 

januaryAv=zeros(1,24);
for i=1:24
    januaryAv(i)=mean(january(:,i));
end

julyAv=zeros(1,24);
for i=1:24
    julyAv(i)=mean(july(:,i));  
end

figure;
hold on;
plot(januaryAv);
plot(julyAv);
xlabel('Hour');
ylabel('Energy Demand (GWh)');
legend('January', 'July');
hold off;

%% weekly

vector=repmat([7 6 5 4 3 2 1],1,53);
vector=rot90(vector); 
vectorWeekly=vector(1:365); 

peakWeek=zeros(365,2);
peakWeek(:,1)=peak;
peakWeek(:,2)=vectorWeekly;
peakStat=zeros(7,3);
peakStat(:,1)=1:1:7; 

% figure; 
% ylabel('Energy Demand (Gwh)')
% xlabel('Day')
% title ('Average Energy Demand on each Week Day')

%label= [Sun Mon Tue Wed Thu Fri Sat];

Sun=peakWeek(peakWeek(:,2)==1,1);
Mon=peakWeek(peakWeek(:,2)==2,1);
Tue=peakWeek(peakWeek(:,2)==3,1);
Wed=peakWeek(peakWeek(:,2)==4,1);
Thu=peakWeek(peakWeek(:,2)==5,1);
Fri=peakWeek(peakWeek(:,2)==6,1);
Sat=peakWeek(peakWeek(:,2)==7,1);

figure;


subplot(1,7,1)
boxplot(Sun)
ylim([70,140]);
set(gca,'YTick',70:10:140)
xlabel('Sunday')
ylabel('Energy Demand (GWh)')

subplot(1,7,2)
boxplot(Mon)
ylim([70,140]);
set(gca,'YTick',70:10:140)
xlabel('Monday')

subplot(1,7,3)
boxplot(Tue)
ylim([70,140]);
set(gca,'YTick',70:10:140)
xlabel('Tuesday')

subplot(1,7,4)
boxplot(Wed)
ylim([70,140]);
set(gca,'YTick',70:10:140)
xlabel('Wednesday')
title('Average energy demand for each day of the week');

subplot(1,7,5)
boxplot(Thu)
ylim([70,140]);
set(gca,'YTick',70:10:140)
xlabel('Thursday')

subplot(1,7,6)
boxplot(Fri)
ylim([70,140]);
set(gca,'YTick',70:10:140)
xlabel('Friday')

subplot(1,7,7)
boxplot(Sat)
ylim([70,140]);
set(gca,'YTick',70:10:140)
xlabel('Saturday')











